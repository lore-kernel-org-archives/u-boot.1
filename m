Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52C7CD8CB2
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 13:58:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26C70848A1;
	Wed, 10 Jun 2026 15:58:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XysSbZcJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5818848D8; Wed, 10 Jun 2026 15:58:07 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 933B88489F
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 15:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-4865e953031so6506356b6e.0
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 06:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781099884; x=1781704684; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BJBmrd3UDJ2ElCEvM9xo+ikTbsS5AALnSj6hUUIR6IA=;
 b=XysSbZcJ4mHamrWPb8af+IRPzZmwPZLuJRFT5CXA+7jg7ZxelxxUIsKzL6AXhR6W6Y
 +OBJLzY18H8Zb+q2NcFRdLwwJpEa6/NR6dXo/tC2G8FAlh0maMgnW1WtL50om0yDV55T
 eoPK/juhJ4+cQPUbdSk/T+kJHh0yY0SXE+LuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781099884; x=1781704684;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BJBmrd3UDJ2ElCEvM9xo+ikTbsS5AALnSj6hUUIR6IA=;
 b=NLnkIG30pYiNwC3909DxSE+HAPelbePnsMknmWYJ4vu44LCm74W5XjghkhqpNEsK4Z
 wVNtOY2ePePzcaEWvxV7IdiKllcOjOxA3kpI93p60tK9kmGAxf1rcPKmIR0ZCBBEQrIz
 gV6fm6SwjcPpWmqjzosQE4hjOOkdjCM6Z0202bqboDz6KV1OuDwHM3mjYAxcIBsLJx4q
 EzXExVNgp5UB/OUq1TNxCPQH0kVgR1xValjJTyyd93j06ibJYNgGVnehyOxg6AV2eOLp
 0DXSUT59YB8jhYShk9hQEdE3PNPUEui2VheupTNpFPhIlZ9YGqWEqdMDMRybf5RA3ATY
 2cQQ==
X-Gm-Message-State: AOJu0Yz3vFUZLzFJahRSKM5gZxJRj+KXZTHQNPNfoou+n7iIZZS2Hfd6
 4mwu+fdo+Oke+6S0xdH3gbMepXreK5B337hTxTNFpEhINu2MolcBHSdau7u5OKdFlmM=
X-Gm-Gg: Acq92OH5U1i4SbnynZb2rrj0+UkLkJN329SdXR8Md5EePLsrIF7GINb0bLlINsLx0IA
 YAl/nFaJp+NVymCoqqbNR9nsuQhkLFg8ZRVm4/R+mDQPN58kqKhD4TPNCRWZ20V/VUw8gf9MyyQ
 azYWdAoL6pRduQViuW/SL8GEy3kha8v65t+McMrUWMVgJ9urnU5VtTdNw2NyXuqYvdfDmEjrenQ
 u9Q5n2iGcZBx76XwAQLu1GmSAkyEFXCw1vxVxH8lNrTqufyBRnTpu4ZEw3ED80Mmxb8WxXVn1C+
 8v2DUb9zPqOO3PBTWETnLTgT5u297MyN3qt5omP5qkN43W8PTvFkNHcu7YbhlMITNZAujQDBLhr
 +15l3G3IYFMSTaRRl4bInaJ0X0z7CL0x+1P4m7M5iuck8ZHJlAR4x5zbQ5LT2ZohZAmTnsFO8JI
 XEyMfDDlVRUvIAeUcDWia+gM9cGAKMaVLsvqy+wFJCNZ+CgBlZ/dojy7DGS3iMs+8GsJoN2KiHk
 zeqYo0dkwl1os1spQ9Jbs4yP+z7mFo5wfDbadyw/dDwxr/TLOG7s1io3SbIN/bBh5GXuII=
X-Received: by 2002:a05:6808:19a6:b0:482:86dc:e1cc with SMTP id
 5614622812f47-48692d7c5admr10554377b6e.17.1781099884260; 
 Wed, 10 Jun 2026 06:58:04 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b5a5b5fsm19449262b6e.2.2026.06.10.06.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 06:58:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, ye.li@nxp.com, alexander.stein@ew.tq-group.com
In-Reply-To: <aijU_urF5yvfqrg4@nxa18884-linux>
References: <aijU_urF5yvfqrg4@nxa18884-linux>
Subject: Re: [GIT PULL] Please pull mmc-next-2026-06-10
Message-Id: <178109988355.235620.14882608867230840734.b4-ty@konsulko.com>
Date: Wed, 10 Jun 2026 07:58:03 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 10 Jun 2026 11:07:42 +0800, Peng Fan wrote:

> Please pull mmc-next-2026-06-10 for next
> 
> -------------------------------------------------
> Convert ofnode API to dev_read API for mmc/power
> Minor fix power on/off delay
> Correct mmc command help
> -------------------------------------------------
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


