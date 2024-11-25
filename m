Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE909D3B7F5
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 09:39:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C0CB890D9;
	Mon, 25 Nov 2024 10:39:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="Qq/yRG9J";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Qq/yRG9J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 303D889659; Mon, 25 Nov 2024 10:39:12 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E762588EC4
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 10:39:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ldevulder@suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6E85621182
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 09:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1732527549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HiKtua++BiY7xSZC9oj8G2mPEYW2+RGsbR514nkAbQI=;
 b=Qq/yRG9J1AXK9yIsgHDuAHSSgqSgxKE8XMlmcLxEfkuSQq4CathHNAnQzSSpN+1npqsw3M
 7vk76dyL1eyFuFyqHTKdPA07OPz9WLqrQTrs8ZlXFGS/ohT3Nzth6mqf8RaykJl2Z7KI5X
 ViWdNxVxAihGAMLloR9SzS7yfyGrmAg=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1732527549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HiKtua++BiY7xSZC9oj8G2mPEYW2+RGsbR514nkAbQI=;
 b=Qq/yRG9J1AXK9yIsgHDuAHSSgqSgxKE8XMlmcLxEfkuSQq4CathHNAnQzSSpN+1npqsw3M
 7vk76dyL1eyFuFyqHTKdPA07OPz9WLqrQTrs8ZlXFGS/ohT3Nzth6mqf8RaykJl2Z7KI5X
 ViWdNxVxAihGAMLloR9SzS7yfyGrmAg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4641913890
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 09:39:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id T+AkD71FRGeoZQAAD6G6ig
 (envelope-from <ldevulder@suse.com>)
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 09:39:09 +0000
From: Loic Devulder <ldevulder@suse.com>
To: u-boot@lists.denx.de
Subject: [PATCH 0/1] configs: visionfive2: enable CONFIG_DISTRO_DEFAULTS
Date: Mon, 25 Nov 2024 10:39:01 +0100
Message-ID: <20241125093908.50903-1-ldevulder@suse.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.79 / 50.00]; BAYES_HAM(-2.99)[99.96%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; DKIM_SIGNED(0.00)[suse.com:s=susede1];
 PREVIOUSLY_DELIVERED(0.00)[u-boot@lists.denx.de];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This is needed for some Linux distributions (like openSUSE) to be able
to load the DTB provided by the OS. It also simplify the boot process by
allowing to use bootcmd* commands.

Tested successfully on my VisionFive2 board.

Loic Devulder (1):
  configs: visionfive2: enable CONFIG_DISTRO_DEFAULTS

 configs/starfive_visionfive2_defconfig |  1 +
 include/configs/starfive-visionfive2.h | 29 ++++++++++++++++++++------
 2 files changed, 24 insertions(+), 6 deletions(-)

-- 
2.47.0

