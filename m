Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA69BC48BC4
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 11:27:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0040287CEC;
	Tue, 20 Feb 2024 12:27:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="N/KYtFrS";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vbJiOhUg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B90E87DCE; Tue, 20 Feb 2024 12:27:51 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5737B879FE
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 12:27:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TfHFW59tHz9spv;
 Tue, 20 Feb 2024 12:27:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1708428463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5+EBHeW91L11zogGGI3kJjn9Sn4zVpY6V92ZpjK3lfE=;
 b=N/KYtFrSSGCcCw5ypGuMLE8oikGh/d87MU3ElqDemi6FediLugBO3SeFyjwgPR1ZSz47yc
 JAr6VKG/cQhiRz/HeUhIkxHKShF/rPKGYTUT38DkCKr4mc1NFKIcbyvQnVu/tZ0Rkrekn7
 v6vK8tSsf0NZlu50RUkfwi/00yrtOiwSs7YWCmUlrmfQ0YaKBHneodpQqM3rbMamGJX+61
 +3auotQZt6O+UZs//JMnzk4DAkx5lqexqO4Vh8eW3OdjLlVmJlXLsjQ8zEXN2OUrDFDk+e
 jX2z83V/FPrW6oyU8qoGhVwElt1CwdZ0lwGu1U8fuYGpizeuI51oGsJ7hwOfRA==
Message-ID: <c14ef3f3-fc35-4c7e-b739-ebb8e36dda74@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1708428461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5+EBHeW91L11zogGGI3kJjn9Sn4zVpY6V92ZpjK3lfE=;
 b=vbJiOhUgadbjU1BbHh1V9A0pLVUI83GniQhS226j1/0eHxV43zSmO6jj7T1YaA8yGSbtXu
 67asYA2aRIWn48AVhRue/g7rC7VM/6Zm2nQgUdbCblVqJCkRiFPsPE+iBuUMb6qW/0f9ar
 uh1PiqVw06Iw0rKBaKJ6hw770cvY+SREruS6KvXDSbVhhntCRJYEOFvtKAAXjOV2D/h2YJ
 m5v0HCYcLr5qyXR1lod+LdFG2Wyrfop/lb7ljTjbfr/lSOZh1UBI6D7QENh6ACPcCxxL3N
 QWQwbfqzvRnVVHr1NebubauJN8T79+SY0qnPQehx+5ff0rgEzPcNOyrA4SVqzQ==
Date: Tue, 20 Feb 2024 12:27:39 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] mmc: Convert hs400_tuning flag from u8 to bool
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Hai Pham <hai.pham.ud@renesas.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Peng Fan <peng.fan@nxp.com>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
References: <20240220083755.34449-1-marek.vasut+renesas@mailbox.org>
 <df373095-3c23-4a87-8590-dca3dcf5c2f0@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <df373095-3c23-4a87-8590-dca3dcf5c2f0@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: c4909a5dd09caa7545d
X-MBO-RS-META: xcet4516ps9p8fs6ppeqer4aswkfxq59
X-Rspamd-Queue-Id: 4TfHFW59tHz9spv
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

On 2/20/24 11:57, Paul Barker wrote:
> On 20/02/2024 08:37, Marek Vasut wrote:
>> This hs400_tuning is a flag, make it bool. No functional change.
>> This will be useful in the following patch, which adds another
>> more generic flag, where the compiler can better use the space
>> now reserved for the u8 to store more flags in it.
> 
> The minimum size for a bool is one byte so there likely won't be any
> improvement in struct size from using bool instead of u8 for
> `hs400_tuning` here and `tuning` added in the next patch. I still think
> it's a good change to make though, bool is the right type for an on/off
> flag.

The compiler does not do boolean packing in structures ?
