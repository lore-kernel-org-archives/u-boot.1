Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502DDCA9EC3
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 13:14:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AB23D608E8;
	Sat, 10 Oct 2026 13:14:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i6lHdRyRXhLI; Sat, 10 Oct 2026 13:14:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 85169608F2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791638090;
	b=ELgg3roXOOmoOx4Ksj+SQ7Vpi8hCJf/6/NkIT4guXV1meTIF9wZqZmphaUVOBxXX/7+s
	 99RbP9wtUDXdrAMyYt9MFEh9ZIz4O/uQFBe7XuuVYobEVVgwpUYLxqIe+LRevBtAZ7Nmu
	 1hbuuT/dGexKLzUp0fB+MvzcQEMenr6FwGD9avfXvF4qaVVqTgjFGJDmPkTVR9WA59ANo
	 h43pSOX/1csitWXF7149GR1tUdbpVqOMnaSAxqkj5vmCVxH2JSYvF2szbDMrhLhUAHo36
	 gDeXFwqsqbHLB+ZOcd6MDSecvIsL8/0aWH+0OZAV6Bb1ARWZ8vWYAz+lxU5tlvQLHxw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791638090;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=AuSrI/1XcdYrH7/21OOhHZlL43R1EquZmzSqr4kTbiw=;
	b=ZmJNNtIaYCHMMXGAIja/kDgkLcK8i6Q/PI4AF5MkQHoWDHyKhfLWvSBK+bP4ffyIstTo
	 JFXHVODE3jzqpsq3YRGV+PPLUUHLU3P9s6yUftEQchXIqr+qiGbQidiIY2aAQnPNzFzYW
	 +lhQcFrorKPfJZ6xVhagTy7YUUUL+aa66iLGXsdZShnktuviDYie/8vmst8gcqNeEi0Dk
	 E0sDeZKjqRgqwmg/sbJWX3sE202jvQ1MjvdwZ5KrILdtsIfo6UKp6yiejz5dYHbwadmqd
	 /9Mg6XFCoE7I7D/bzMZI8a5x4mZCHrUmpv7pY9v759eaKV/UUcY5G9GQhM2uLJSiwzA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jZCCGvrW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791638089;
	bh=AuSrI/1XcdYrH7/21OOhHZlL43R1EquZmzSqr4kTbiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DIMO/dU3vNLK+wsi1PbIHpd5Q6Zgt4hYPy0Pd52Mbm59VpYXNfS1nQJjpuBxrZRTO
	 LJMRRZpEv3SalSb7U8D2D/ZXGL4RBQmcQcqPCKLD0YxOT/ZTPTd2g4zPCRnydk31Em
	 Nnygx6VTsTs9Cqg4hqIgTLgImTUKrkpf9BWQkE3WE5VrZJgcsErytTnziQqy3ONzHE
	 J+ujpkdNIG2SjfM5tKS2qKoKGGjqcUpTfZvGE2Tk1uR9zsngipkU5ysWNKHiNucx3b
	 +G0q9/9CL1JgIoGIUQT30gzQH5RJvETRtAtFOGIWknYIBxSH6jNq56tmKjVDCJ3Q3Y
	 ULk1mHaql+Wgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 85169608F2;
	Sat, 10 Oct 2026 13:14:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 441D6105
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 10:14:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2971860622
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 10:14:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1oAB9vFIBYeE for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 10:14:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7C4A960662
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a33"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791627277;
 b=IegUyvpA+n1Shh3EM75sxnXQ+5gKJySgQQNgF5EM6tpPOR+qDXCYu3fN8wTRP/hRujPl
 Q/8QXlO79s7P+aB73jLKWgFbj9WuR+Q4ZwSw9ryDMIgz2ZIecj0ipTquyDAAD6+XVBG1G
 11MLu/vxxIBO80cYCVScKuekYIvgi9Kc638O4wPvVzlL4od3EUpHffK/HZG+xWktOyNaV
 zKuBXwTcdBrFgsiZTO8gWiFouR1BO1rFc4JNfdKYGFHM7JjuIRaw5u19mtdkz6cMbZEwt
 K7TOg/utaaic5W1Slm9UON/7FbpIV7GILqRpowoC4YdsDfqzo1JKgdEREsVyRg1Ekqg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791627277;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=AuSrI/1XcdYrH7/21OOhHZlL43R1EquZmzSqr4kTbiw=;
 b=PaNSObLGsGu1BMlE54Z7NSQmLBJDtlCQv1VxqxhVycmOwMFxZzRFxDpPpYpcQHelyFDY
 ddHvidOJ7ym1tbLVe9sdwVuO+WinEEf5TdJCaBflykir7hBujOdHD+N+4cVNy33juxjt9
 pmL2WyjlPxUbU8y0yDYTfUu0e5+7WWKSbyVBXmYcBbjQsxBuRMogPGol6LXU+5eZYP10E
 QLMpBNnAFoyYJx2z2aTq5H20wVNfgIoOmsgnwU3cL7pGD4F7zR/w2mJ/thpR5hwSIaIFM
 SZGLSPm9UP7fUiww18WpNBK5Ob/izDuh+01849AIr+x1c5V7QvS1qEW0zeD5JUtA1DQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jZCCGvrW; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a33"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a33; helo=mail-vk1-xa33.google.com;
 envelope-from=vinicius.eduardo.pedrosa@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jZCCGvrW
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com
 [IPv6:2607:f8b0:4864:20::a33])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7C4A960662
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 10:14:37 +0000 (UTC)
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-5dc2dc6d3fdso188112e0c.0
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 03:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791627276; x=1792232076;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AuSrI/1XcdYrH7/21OOhHZlL43R1EquZmzSqr4kTbiw=;
 b=jZCCGvrWP4ZNgD2qCD7ydPOI9vzRqAzdB2/TX+53IPTSbOj8wmvbZy6+7nkPRAvYW6
 7t4HUjCD18MPjJf/+8sGg33AE+uFFTcLp+I1F6HpLa7LT+2qCWp2MRw4lN35QpnTH3k7
 wSIl8bVXneSKy2atlZtyUSGxtDdPd4KELl/MbUlKivnRsENMOFvnGbdVSkC8rQ2Y5PX6
 /1SjXqHeK6PlwaBvT1M3geoUsoYb0FMSK6Rjj/Kkq0QeJJ4yZaEnJ5DxuxIe8XYUchhx
 dLPRbANbOidkIZn0IOL/Kp4cUDxdv2exJmk9zmzas2DOqv8a88KdJC+3d0CgoIRTGF1t
 3iaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791627276; x=1792232076;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AuSrI/1XcdYrH7/21OOhHZlL43R1EquZmzSqr4kTbiw=;
 b=FY7MNrOWndksqQYKHTnAurvGYd8PmoMkNsfGNpArmfMC0G4Mhib3JfVtiHwOXMPdPq
 +P+pJAst+cr8xN1ffa2i5QpCz6v1uM/B6gWknYQglzN+OxdRpALrHCjzaGiEWNQ3IPMV
 dRa1gKgYXGsQFFbdqGhl9W925kRtB24WLy8qEjhGadm3pys0RU2IqL1cDJe8oWHXR64G
 2fMEMnK2AZ4lwvmRA+vPaCJNj/sBIyp6x4nszx5cNxu9nydKb1uOp1Q2h+MpTFn67Oo5
 2/74DFQBRZe1xQ8ZfOIOQaXOkeeUidYw2Ci1SmWJfXU6VcEhhENTAFaajCJKFwOdFi4V
 k1ug==
X-Forwarded-Encrypted: i=1;
 AKwUvBy2rlNFmvYmGfryjsavY4jLSLvZ0yAz9CmqyRSqVwmPA0GkMTXl9gDVvKLmvHFIIsKA6UZKo7w=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJGq6igxoQzKtn15ExL2XS1e8628ZOU3bJQPIG4fu6M4ZOhlShd
 IX3OvdT8t2a5mvvLMe6TGfHIhGD3k9tljfkBwTxj54KjBfDTtfaTvLMn
X-Gm-Gg: AYBFou18+g+8Hx++ae35l0BHCdhVLhh5YlcFRSBJnIHMp7Q0QyWwVFCEDIvSvakowsI
 B3SkjPIsNCNia6DO96pVi/ac1lJNiwn1gtrNUUHeYNe1yE5ks3+pGYx1qjrmOmxE7NbsZiB5sMM
 Hf8KgMFdnNCpCl592z4wNgVAp1LIh5E4fGCrBgItJdc4KZzrAHR+flt/QBZgbJWNWhYRC8bjcOa
 IuiPz260WdTxb5fmGES3FzesNEZfIVMyyw5jtMTRn+ftTx+Q5SWAnXku44FEGL3lCFLgs1UJIac
 P2I6ckTEqAwf3L/d06hhxuTNpRtFAy33jJmcky1pO6mST2YGsc70Xu+UKbcRsQa/7sRiK+QOQC9
 BpoLfj+k3L/xHPge3ybQ/KDdRNXPEpxYqHXVyBU5fU4SmDRnZHDvhci+1Dz2g8AXGX2qo/+UX/C
 lanH3AASs9XXh5xrbArHcbYRAQy+BdRQmbASO1DNVp27DI899jAJpU3fr1lWkFVaxXK6kCsmX6d
 oRLcCm4wkmnjr6yu0Qi3XTq/S2OcrAk8Y0IoMq1mKWYTm3jGjdEi/xMkLPla7xChdhb/XlOaUHN
 QBHIn5Im
X-Received: by 2002:a05:6122:3c4e:b0:5c9:a60d:327a with SMTP id
 71dfb90a1353d-5e91f4ebf20mr1428237e0c.14.1791627275896; 
 Sat, 10 Oct 2026 03:14:35 -0700 (PDT)
Received: from MaquinaLab.. ([179.179.237.181])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5e91c841a45sm3662304e0c.2.2026.10.10.03.14.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 03:14:35 -0700 (PDT)
From: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
To: Alastair D'Silva <alastair@d-silva.org>
Cc: Andre Przywara <andre.przywara@arm.com>, Yixun Lan <dlan@gentoo.org>,
 u-boot@lists.u-boot-project.org, linux-sunxi@lists.linux.dev,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Paul Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v3 0/9] sunxi: Add support for A733 SoC
Date: Sat, 10 Oct 2026 07:14:17 -0300
Message-ID: <20261010101417.55385-1-vinicius.eduardo.pedrosa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <277fbb28e539eb61d492b3d1c79db12d5eba6078.camel@d-silva.org>
References: <20260113-01-a733-soc-support-v3-0-f19dcd098f60@gentoo.org>
 <20261009120356.194364-1-vinicius.eduardo.pedrosa@gmail.com>
 <3f57db40-a604-4800-b15f-2d159a3a5ca7@arm.com>
 <277fbb28e539eb61d492b3d1c79db12d5eba6078.camel@d-silva.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 10 Oct 2026 13:14:42 +0000
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

Hi Alastair,

On 10/10/26, Alastair D'Silva wrote:
> I would be very grateful to have someone help ensure the PMU firmware
> can successfully bring up a DDR4 board.

I have a Radxa Cubie A7Z (A733, 1 GiB LPDDR4, Nanya NT6AN256T32AV-J2),
which I assume is the DDR4 case you mean. I can test your clean-room
firmware on it when it's out, RAM only through FEL and serial, and send
you the logs.

I've analyzed the vendor boot0 DRAM code, so I'll keep out of your
firmware and only help with testing.

Thanks,
Vinicius
