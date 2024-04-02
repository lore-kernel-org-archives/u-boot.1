Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5383C6FD1F
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 08:58:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D1298803F;
	Tue,  2 Apr 2024 10:58:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="xUMedfTN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QAFhLlt5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C23BF87FDA; Tue,  2 Apr 2024 10:58:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCB228803F
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 10:58:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 56D90344A3;
 Tue,  2 Apr 2024 08:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712048308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zPekTSsqKbOOUYd7W01+StsjbXrhxyZVbWO8hjsLTjM=;
 b=xUMedfTNuREx6tMGBTf6fBNUqFyx5bO6yIFebiZhFAnqrIoKmYoaXbbmQzCV/U4DD1pnBm
 wxW1wHGIoNE+KgYlKQWqBa2qFcdX44VSIEMj0acT1OImOY/7ZN6ZG2AUAcribsW2Ynu9ZX
 bPkGV1f7PAMaL+8Ojiw9V+LCuFt9jdA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712048308;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zPekTSsqKbOOUYd7W01+StsjbXrhxyZVbWO8hjsLTjM=;
 b=QAFhLlt5MWXVIqQHgq/bryRDMWVaLAdQpbBEUMkyEko8mVtpmxrIvW56SHP/OyTPLBNWFp
 yFLB05NxdETX6iAA==
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B66E13357;
 Tue,  2 Apr 2024 08:58:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id UYtQErTIC2bOcQAAn2gu4w
 (envelope-from <iivanov@suse.de>); Tue, 02 Apr 2024 08:58:28 +0000
MIME-Version: 1.0
Date: Tue, 02 Apr 2024 11:58:28 +0300
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Stefan Wahren <wahrenst@gmx.net>, Peter Robinson <pbrobinson@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>, Naushir Patuck
 <naush@raspberrypi.com>, Bartosz Golaszewski <brgl@bgdev.pl>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Conor
 Dooley <conor+dt@kernel.org>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Linus Walleij
 <linus.walleij@linaro.org>, Nicolas Saenz Julienne <nsaenz@kernel.org>, Ray
 Jui <rjui@broadcom.com>, Rob Herring <robh@kernel.org>, Scott Branden
 <sbranden@broadcom.com>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/3] dt-bindings: arm: bcm:
 raspberrypi,bcm2835-firmware: Drive-by fixes
In-Reply-To: <20240327233700.GA21080@pendragon.ideasonboard.com>
References: <20240326195807.15163-1-laurent.pinchart@ideasonboard.com>
 <b044eec1-ae64-4de7-9ab0-e3fe756131ef@gmx.net>
 <20240327233700.GA21080@pendragon.ideasonboard.com>
User-Agent: Roundcube Webmail
Message-ID: <bcf8093ab0ea6f3738bf4a4623de700a@suse.de>
X-Sender: iivanov@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.79 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; XM_UA_NO_VERSION(0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[19];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net];
 FREEMAIL_CC(0.00)[gmx.net,gmail.com,raspberrypi.com,bgdev.pl,broadcom.com,kernel.org,linaro.org,lists.infradead.org,vger.kernel.org,lists.denx.de];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TAGGED_RCPT(0.00)[dt];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:rdns,
 imap2.dmz-prg2.suse.org:helo]
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


Hi,

On 2024-03-28 01:37, Laurent Pinchart wrote:
> On Wed, Mar 27, 2024 at 07:49:38AM +0100, Stefan Wahren wrote:
>> Hi,
>> 
>> [add Peter and Ivan]
>> 
>> Am 26.03.24 um 20:58 schrieb Laurent Pinchart:
>> > Hello,
>> >
>> > This small series includes a few drive-by fixes for DT validation
>> > errors.
>> >
>> > The first patch has been posted previously in v1 ([1], and now addresses
>> > a small review comment. I think it's good to go.
>> >
>> > The next two patches address the same issue as "[PATCH 1/2] dt-bindings:
>> > arm: bcm: raspberrypi,bcm2835-firmware: Add missing properties" ([2]),
>> > but this time with a (hopefully) correct approach. Patch 2/3 starts by
>> > fixing the raspberrypi-bcm2835-firmware driver, removing the need for DT
>> > properties that are specified in bcm2835-rpi.dtsi but not documented in
>> > the corresponding bindings. Patch 3/3 can then drop those properties,
>> > getting rid of the warnings.
>> 
>> since this series drops properties from the device tree, does anyone
>> have the chance to test it with a recent U-Boot?
> 
> I don't have U-Boot running with my RPi, so I would appreciate if
> someone could help :-)

Sorry for taking me so long to verify this.

I think on RPi U-Boot side we are fine. API used when accessing Mbox
device do not follow DM model and do not use DMA, but just access
device directly using this nice macros phys_to_bus/bus_to_phys.

I build new DTB files with this patch included and U-Boot build
from the latest sources. No obvious issues on RPi3 and RPi4.
Devices boot fine.

Regards,
Ivan
