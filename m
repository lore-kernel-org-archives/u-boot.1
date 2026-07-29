Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA828C53219
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 15:34:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4AA3D6068F;
	Wed, 29 Jul 2026 15:34:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V8YXZLIY9ySS; Wed, 29 Jul 2026 15:34:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3CE316061D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785339253;
	bh=ntnVWhyXGaEWwzLvLSVMsz8zD/5NJK319jyZ1nELMWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RRH5UNi112DvpxzYP+GN2Kh7o60OfNiQnI5khK/xG+ubXh4E1EfHIlutgrpAgOB0H
	 jCgOlQ5MOVaTk/+SL/+kKYo9UoM2PW3R4bVooRp/CXnt3CxZEWx6Cxzo3pUrHUOHUS
	 cq5w66oYSu45WupchSH4NYhy/o/LQB56gVaGhImhH6UbckfH0aqggTO6rPnIhJCPtM
	 S70IjXu4VvnxEaEMVxwMGZKDHhWfh1u0vUpL2xc/NwKfdV7N2j7sv6iL1Utbjg7xO9
	 s3CUQ3R1o/XcKru/62udp8M3Zv5Po4ELEf7ba5ZEZf8xybPD/QHaUNBCz45NaGxAcC
	 APry0+xGGfdeA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3CE316061D;
	Wed, 29 Jul 2026 15:34:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 896F83B0
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 15:34:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6F3D4406EE
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 15:34:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E0ARa3wn50Ji for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 15:34:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=jcormier@criticallink.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D6D39406E0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D6D39406E0
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D6D39406E0
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 15:34:09 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AB1D8493F; Wed, 29 Jul 2026 17:34:08 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D21CB82991
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 17:34:05 +0200 (CEST)
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-92e65e18969so80519185a.1
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 08:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785339244; x=1785944044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ntnVWhyXGaEWwzLvLSVMsz8zD/5NJK319jyZ1nELMWk=;
 b=bPyGFZ1tNMO3RE0F7diZBlzI09GBGJOnFH62TWLAblRTTGsa0tFouYVnT1pBLUveqI
 OGuurgK74IJAbnjNW3fCpwtFtmQwxOn0AciQKiFH2Qe3ShXBswpnzrK2Ddi4Ykz7LYQO
 ancznVPaS0FEzpbjIEGnBVmMABwrUzk3ZQM5FmmNcsDXPEFHunBgF12hWZsER26Gi7Ho
 UBNxnFZDcRyNp/a4/1wXaO7GAWf64LCK7PilRsu/A72re4nLn9gR4fKsHaUe08RdXyam
 aCuIQ6y9J8fWfu/HA0C9ZUQPG+60NqcsBRoA+G+VP8PumCG0W2C2u9axqGspfcFoKIhY
 bUqg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpwp5vi1xqPWj0mlhbSpBu3lNKSXuy40N02Yy9XvISpNEvQaX6zthLMnLkjfqJSD83rLamTKG0=@lists.denx.de
X-Gm-Message-State: AOJu0YyokoY+feDe8NFgGEmelgkI+J2t9ubEtY901kBWV4v2hbCinISs
 7MoD75wPWqsBLNumTApCPeERz2SUKfjEb62LoQDzZtQLqfXIoiBJy9IwCboLSsM/fw==
X-Gm-Gg: AR+sD10A2TaHPbUGwQZUfdsecTemxHmd6tC/tzH8L1Th6OxaxMUmjnQQ5LKXbu2UnGf
 aADhQgZcd/DQb3SIEIRwOoChgZjQBZiYdGnKnD21HhZ1J0jObQbWnNNzdFYjoHN5BT8lRjDZanq
 +xL8l1q/V4OF4ihMvblIvKS8MwbBjPDXECHWjwGDVAgFRynhh+EjEtgGpQIa18wRfBa4k/bKMJk
 PNWOg00A3882tXDrvuOxLBjRA/vQhA0UWkDDYRyPrD/qSvIsFefVXOx2KTA/kwTuPoraQczwai2
 1yNGkLhS7mVR+sZ+sbnWjU0zgQtmFp8pWiJSANaIAI4D/8jmRcNoG3zmhtPdIKnZl/EAhemYaXP
 +iXdV6HRsw78rsxeHpdmnSt2Pt8OReVIk98wrEmtpAp2nlRth8HU/iNEXWxHgQFbZNDlPArBTMF
 rt6dO0DTelil71WCwJ7aumFyRi2D5i/pxKYMBWnUaRTUrw4xU+Ro5mIptbGioN3y/rthZlTg6tY
 IKGFx/vBeQhyfJfJih6EHcOmbNXQixMz2hYlrW3gCPF71QYUf29VrW+lhS6eqbUtf7wmu2RbftP
 wA==
X-Received: by 2002:a05:620a:6e88:20b0:915:9f30:23cb with SMTP id
 af79cd13be357-934793ff575mr179423785a.0.1785339243650; 
 Wed, 29 Jul 2026 08:34:03 -0700 (PDT)
Received: from jcormier-MS-7A93.syr.criticallink.com
 (static-72-90-70-110.syrcny.fios.verizon.net. [72.90.70.110])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-933d3221c71sm196211085a.2.2026.07.29.08.34.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:34:02 -0700 (PDT)
From: Jonathan Cormier <jcormier@criticallink.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: Jonathan Cormier <jcormier@criticallink.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Aparna Patra <a-patra@ti.com>,
 Bryan Brattlof <bb@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Dhruva Gole <d-gole@ti.com>, Judith Mendez <jm@ti.com>,
 Beleswar Padhi <b-padhi@ti.com>, Andrew Davis <afd@ti.com>,
 Aniket Limaye <a-limaye@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 3/3] mach-k3: am62a: add support for speed grades
Date: Wed, 29 Jul 2026 11:33:56 -0400
Message-ID: <20260729153357.3161675-1-jcormier@criticallink.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030-ti_speed_grade_fix-v1-3-703e4189640a@ti.com>
References: <20251030-ti_speed_grade_fix-v1-0-703e4189640a@ti.com>
 <20251030-ti_speed_grade_fix-v1-3-703e4189640a@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=criticallink.com; s=google; t=1785339244; x=1785944044; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ntnVWhyXGaEWwzLvLSVMsz8zD/5NJK319jyZ1nELMWk=;
 b=hJ6UOFGaHNbt34sfICjVv3tbwAztaYfg4XR2FLmBUk00K/Um1kzwCJqjnAEQZFSYm0
 KGZpMaBRZnZqdH8l63x21ffB5VRctSLgbKtxeALtpPxCQCnKKttl3fzGRjlZMnayqe2p
 xgpHpVy/AshOJqW40w+cyddkf+UXfhWuNqvHYLgZU6NvDxH9bSxpN9/56rRvUN7uZG8r
 bH/xAN3SI28zlBv+d/Kd9DgpX+kfnfkGmzxaRdPZ3BjJYC9yxMwiEEEi8BmuOBAJI1Ky
 aH6tv7MbwQkeiyjqPIumBpV11Wg6mYMF2xiBPa+nWpW6fPBndUwK9DX9uotG+2usc3cY
 lgcQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=criticallink.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org; spf=fail
 smtp.mailfrom=criticallink.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=criticallink.com header.i=@criticallink.com
 header.a=rsa-sha256 header.s=google header.b=hJ6UOFGa
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=criticallink.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=jcormier@criticallink.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=criticallink.com header.i=@criticallink.com
 header.b="hJ6UOFGa"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Anshul,=0D
=0D
On Thu, 30 Oct 2025 18:33:22 +0530, Anshul Dalal wrote:=0D
=0D
> +char k3_get_speed_grade(void)=0D
> +{=0D
> +	u32 efuse_val =3D readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);=0D
> +	u32 efuse_speed =3D (efuse_val & JTAG_DEV_SPEED_MASK) >>=0D
> +			  JTAG_DEV_SPEED_SHIFT;=0D
> +=0D
> +	char speed_grade =3D ('A' - 1) + efuse_speed;=0D
> +=0D
> +	/* Speed grades for AM62a are not sequential */=0D
> +	switch (efuse_speed) {=0D
> +	case 'T':=0D
> +		return 'V';=0D
> +	case 'V':=0D
> +		return 'T';=0D
> +	default:=0D
> +		return speed_grade;=0D
> +	}=0D
> +}=0D
=0D
I think the T/V swap here never actually takes effect.=0D
=0D
JTAG_DEV_SPEED_MASK is GENMASK(10, 6), so after the shift efuse_speed is=0D
just the raw 5-bit field value, i.e. somewhere in 0..31. The switch then=0D
compares that raw value against the ASCII character literals 'T' (84) and=0D
'V' (86), which are well outside 0..31. Those two case labels are=0D
therefore unreachable and the switch always falls through to default,=0D
returning the plain sequential decode. The swap described by the comment=0D
never happens.=0D
=0D
In practice this is harmless today: k3_get_speed_grade()'s only consumer=0D
is the A53 clock-rate fixup, and grades S/T/U/V all map to the same=0D
frequency in am62a_map, so swapping T and V can't change the result=0D
either way. So this is more of a correctness/readability fix than an=0D
active bug.=0D
=0D
I believe you want to switch on the decoded letter rather than the raw=0D
efuse value:=0D
=0D
	/* Speed grades for AM62a are not sequential */=0D
	switch (speed_grade) {=0D
	case 'T':=0D
		return 'V';=0D
	case 'V':=0D
		return 'T';=0D
	default:=0D
		return speed_grade;=0D
	}=0D
=0D
Since this series has already been merged (it's in mainline as of the=0D
2025-11-12 pull), this would need a follow-up fix on top rather than a=0D
respin -- happy to send one if that's easier for you.=0D
=0D
Thanks,=0D
Jonathan=0D
