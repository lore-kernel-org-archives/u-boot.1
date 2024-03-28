Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB46C54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 07:39:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52E7D87F4F;
	Thu, 28 Mar 2024 08:39:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="nowIQRK5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aBhbtePb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OWVQqGOD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="a0E4Smwm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B502880BB; Thu, 28 Mar 2024 08:39:07 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF74C83346
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 08:39:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 674B820563;
 Thu, 28 Mar 2024 07:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1711611544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vPrUGDqN2icStsuvWnlcO4k/Er5XD+UvJPRnl5Hlr1M=;
 b=nowIQRK5VK0l8Vht81ZOeXpPOe/scqQK7kvTil5o35X5sYO4hC0oSVSU+Stvr4LAPAlxZS
 sx1n8PzV8Bbxx87oJrcyZOVAk+wyEyK0hGkWN1dV7DwE/HxIj5DM4vPebRUpHdRT+TD1cq
 5oAjpzIwsjpX+UHejWtOeKkHYHptZaw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1711611544;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vPrUGDqN2icStsuvWnlcO4k/Er5XD+UvJPRnl5Hlr1M=;
 b=aBhbtePbpGO1ap60ZwtRQGzpIwO3kdBMADwAXtWSAT7WmvVr9FfY/+gmUP3bmBm/RcRfFM
 vaFFhy3xWC0rDTAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1711611542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vPrUGDqN2icStsuvWnlcO4k/Er5XD+UvJPRnl5Hlr1M=;
 b=OWVQqGODH85USjpp5alHH+KsdkkHgDZe4wAYk12NSj65HgYGMo5jQLOSHgK9nTnqyfCAN9
 X+bANLF9JvxEGvd6GCUkFD/1+8ZhKvOCna70OA3MAlUOgU8+KfgefsQF24eTfc9oreh7hC
 bp2X55l6nWV1U+rqb7TpVRxeL6eqJiY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1711611542;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vPrUGDqN2icStsuvWnlcO4k/Er5XD+UvJPRnl5Hlr1M=;
 b=a0E4SmwmyIsBzu3qtQxNAg4yq71AZR7TpHfyEvkVTYJ7twIE1QSmJzLlpREYpVv0+nLqwq
 H+KChf4JZJQmf7DA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9275613AF7;
 Thu, 28 Mar 2024 07:39:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id N4xJIZUeBWZ+TAAAn2gu4w
 (envelope-from <iivanov@suse.de>); Thu, 28 Mar 2024 07:39:01 +0000
From: "Ivan T. Ivanov" <iivanov@suse.de>
Message-Id: <DADC8DC6-9320-4696-A3AD-03E65BE4EF80@suse.de>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH v2 0/3] dt-bindings: arm: bcm:
 raspberrypi,bcm2835-firmware: Drive-by fixes
Date: Thu, 28 Mar 2024 09:38:50 +0200
In-Reply-To: <20240327233700.GA21080@pendragon.ideasonboard.com>
Cc: Stefan Wahren <wahrenst@gmx.net>, Peter Robinson <pbrobinson@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Naushir Patuck <naush@raspberrypi.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>, Ray Jui <rjui@broadcom.com>,
 Rob Herring <robh@kernel.org>, Scott Branden <sbranden@broadcom.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20240326195807.15163-1-laurent.pinchart@ideasonboard.com>
 <b044eec1-ae64-4de7-9ab0-e3fe756131ef@gmx.net>
 <20240327233700.GA21080@pendragon.ideasonboard.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)
X-Spamd-Result: default: False [-2.30 / 50.00]; ARC_NA(0.00)[];
 TO_DN_EQ_ADDR_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MV_CASE(0.50)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net];
 TAGGED_RCPT(0.00)[dt];
 MIME_GOOD(-0.10)[multipart/alternative,text/plain];
 BAYES_HAM(-3.00)[100.00%]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_RATELIMIT(0.00)[to_ip_from(RLcpbji3m9padrda9d1k9j5djo)];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MID_RHS_MATCH_FROM(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[19];
 DBL_BLOCKED_OPENRESOLVER(0.00)[ideasonboard.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+,1:+,2:~];
 FREEMAIL_CC(0.00)[gmx.net,gmail.com,raspberrypi.com,bgdev.pl,broadcom.com,kernel.org,linaro.org,lists.infradead.org,vger.kernel.org,lists.denx.de];
 RCVD_TLS_ALL(0.00)[]; SUSPICIOUS_RECIPS(1.50)[]
Authentication-Results: smtp-out2.suse.de;
	none
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

> On 28 Mar 2024, at 1:37, Laurent Pinchart =
<laurent.pinchart@ideasonboard.com> wrote:
>=20
> On Wed, Mar 27, 2024 at 07:49:38AM +0100, Stefan Wahren wrote:
>> Hi,
>>=20
>> [add Peter and Ivan]
>>=20
>> Am 26.03.24 um 20:58 schrieb Laurent Pinchart:
>>> Hello,
>>>=20
>>> This small series includes a few drive-by fixes for DT validation
>>> errors.
>>>=20
>>> The first patch has been posted previously in v1 ([1], and now =
addresses
>>> a small review comment. I think it's good to go.
>>>=20
>>> The next two patches address the same issue as "[PATCH 1/2] =
dt-bindings:
>>> arm: bcm: raspberrypi,bcm2835-firmware: Add missing properties" =
([2]),
>>> but this time with a (hopefully) correct approach. Patch 2/3 starts =
by
>>> fixing the raspberrypi-bcm2835-firmware driver, removing the need =
for DT
>>> properties that are specified in bcm2835-rpi.dtsi but not documented =
in
>>> the corresponding bindings. Patch 3/3 can then drop those =
properties,
>>> getting rid of the warnings.
>>=20
>> since this series drops properties from the device tree, does anyone
>> have the chance to test it with a recent U-Boot?
>=20
> I don't have U-Boot running with my RPi, so I would appreciate if
> someone could help :-)


Sure, just  give me some time :-)

Regards,
Ivan

