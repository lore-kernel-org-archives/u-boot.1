Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F13C55172
	for <u-boot@archiver.kernel.org>; Sat,  1 Aug 2026 14:25:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3BD8F80D1F;
	Sat,  1 Aug 2026 14:25:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VUPsAmScvZGF; Sat,  1 Aug 2026 14:25:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 50F3980CDF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785594302;
	bh=razj7EZVJj3fNiHDAmEq7ZK3Sy9uaDzE8S7aJTWTMxw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Awj5QZuQa9FlkHPVHTxsRryiYzNkWj5hHC5SnSC83RXv992rBump2v1w0HLqOPZvr
	 mtV/6NfcVxAdBLM/N6MZcc2vIEskaVzciCvE9reqOZx5IfucBQlnejI4LReFXYjPUr
	 PZCO2jXIiPwyc/snL7WRHjoIdaKkdFtt0qRV1pL2S5Fm923ypkszrG28HnGjDlJfPg
	 Ig/ZYzrUD5AfUAuHIZPn9eQftghp2gl0ZRa2uTqvNZNHTC6l6yHIIiFlDCdEv0YP22
	 kgqExUC4S2X2Cti5vH/OsaANvgV16yEZCd7Pe7dQc8qkSNxNb9lJuMTbxXl72eOSLz
	 FduRjgDQdcSyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 50F3980CDF;
	Sat,  1 Aug 2026 14:25:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 670F33B6
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 13:08:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 58925400D8
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 13:08:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rW2Su8S8XexS for <u-boot@lists.u-boot-project.org>;
 Sat,  1 Aug 2026 13:08:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7DA7940077
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7DA7940077
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7DA7940077
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 13:08:11 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2caced6038eso18977295ad.0
 for <u-boot@lists.u-boot-project.org>; Sat, 01 Aug 2026 06:08:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785589691; cv=none;
 d=google.com; s=arc-20260327;
 b=AvU7zEmmtBKMeb+its3CjQ6EKCRbw2R0Pv7iExoEaSdDqNzT7UC+OtqwcQTMuFo/YW
 om3r3fBxUOdjyhRLXb/WmFdyT9hNUeLCCG+NLWKlu3qAX7weSi6ZoD3yWrs5cL6o8vBt
 rzSckCVIxO1RZvGI2nAEyvEaeGvYbB21bnCLLwSqO+6oft/8jhkVyMxWGphpUbwftRtX
 kvsJyImGd4o9Y/fql52p8qHRpkt6H6taBUhQtMCaC0ax31xRXtE4kSSEJ3+EhOiV/cNE
 ZIzmP7dj6YxlvLW1VSpRx8KJmmkXFqGC28zb/L/VtibceH4t1Pg1d8r7+izTZnIMvyOP
 oA1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=razj7EZVJj3fNiHDAmEq7ZK3Sy9uaDzE8S7aJTWTMxw=;
 fh=WTw0HQCOQghtz1KG4fepiCKbh/8jw1gho+8/oqQAM5o=;
 b=oqNgCkAE8AjlyT78/a6/RnhPGUvBfJPNRwdCahBQlM1kT7GhtQbviMgIp+03bdBRxq
 BGIzIyAVp6c6mPCCDBEIAaDG5heLY3ZwXs8u2g48xHn0Uz8W/UxS2S4wJl/gsCUC4NzP
 dQ3BbjOTl+ELnRfN/SBEMPzjNltBWn9UosjzaDP1x8Y5EGeJyMuFnXcAVJFvLBfdVjOm
 WjDBo7TUMY1WdTOwdGcFT/opTxIqLPpBc/TX9E3tik/FyJ8iC9cClyEc50MyXaSYCFO7
 HCCFeZ9ZZNx1YNQrArMI+7PJwe7aypmUEhbtAv3S5tGuLYfh7WO41n8VYxoQx7dX/c2t
 m9ew==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785589691; x=1786194491;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=razj7EZVJj3fNiHDAmEq7ZK3Sy9uaDzE8S7aJTWTMxw=;
 b=me00vyF2S3M9E+5E72TKAZ7UMIfjWAdKtpgL2DbsQxEH9nPVFbPhBXc9/vb0zHdPeJ
 7FnzCl2PWkuXhpzKXy6U9ZB2K+1Ypg6fY+gdrBwBfPBzrusuetuHYsNh+wYLjmJqAyzl
 ET7Ar+HKIG3Ai9ANW8RZqy8QndC92iMxQehENRpAwqgnvbyam9PkbedxwqyUn4mBFtVW
 zMcdC42poXJwDn1m5iqMagU3garKSeHIGMxoNglMNE0qtw8XUBXnoAJ3fqQGsTBXEZ7Q
 VAhwg5UCYuLc9FkO2WUTQyD1qE4xttQjLJUCFrT5g5Jxu8jHrcFrkIZv1oab1T/2eWvL
 cVHg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoFXhJ7Ff+9by+ivlG9PsHHug7jw30JCTETHQRMqW0OpYln1AK+0SsumaP22up7UXD23cfOcmc=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxS13y+BPGwTCaoWIDbiu9gLApxybJlh5sc5rWSxfGHwHXmL314
 wAZj26Ve4q6emPEfqMbnsarKit0dL1eA5mipg/8R9Uv+ToXLeeZ+JgIg3K8wM64uHnX/rD+xHlw
 p3tdwa5nvVhS5bswMadGcA8RxBBmRNoKzX8FzBEx+tA==
X-Gm-Gg: AR+sD11ywmg4MilQIUMAhESyif5vGDy3UjENF3AqqTpoO2zBWobQYUZyz6EOYPLwGQe
 2OIcbWG2uhxr8LfivJXuN0jdoZsgIKh4yWfGbx58mbam0RBpFOTeC741k/kK1g+eg7ys4fkZijp
 x86CHisrXemASRu4b48MtUUihryLIL8KlNKPSlI82g5Ms13V0nQbt2fmjd+dd4lRS+ssfA+DgF0
 2TaHWqLHq++3/PzJoQr+/uB0gTS+j2R/0NkoyJjHgTwqGKt7oUa+yoIx9Tegnsz4rv/aGvFQieR
 d1SkMbWF+vcCwejIkZ0VURJ07pktjjqLnu7+hEFVQGXhX/+g6uFzXmlFQc8V1ZOyZrHcOHQbkec
 vykd9kAlwU81WIXBhcuG++n0WCw==
X-Received: by 2002:a17:902:f64c:b0:2ca:f417:396b with SMTP id
 d9443c01a7336-2d047d1ea9bmr51789895ad.3.1785589690579; Sat, 01 Aug 2026
 06:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-rzn1-2026-07-v1-0-af2ce80db9d8@linaro.org>
 <20260731-rzn1-2026-07-v1-3-af2ce80db9d8@linaro.org>
 <800f6c85-7854-4b7e-9509-3006c3ca8b42@ti.com>
In-Reply-To: <800f6c85-7854-4b7e-9509-3006c3ca8b42@ti.com>
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Sat, 1 Aug 2026 09:07:59 -0400
X-Gm-Features: AUfX_myLAhZydgCETY4u549Lcng9yV0xFqiQlkwyItqhddvtWsCVVU-EPpA0Jt4
Message-ID: <CANp-EDa+2Hdzg2nn9mcOupkLNPvAohnu_1UZ9AaysG_gvK==AA@mail.gmail.com>
Subject: Re: [PATCH 03/17] spi: cadence_qspi: Use APB write protection
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>,
 Padmarao Begari <padmarao.begari@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sean Anderson <sean.anderson@linux.dev>, 
 Boon Khai Ng <boon.khai.ng@altera.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Robert Marko <robert.marko@sartura.hr>, 
 Jim Liu <jim.t90615@gmail.com>, Ben Wolsieffer <ben.wolsieffer@hefring.com>, 
 Stanley Chu <yschu@nuvoton.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Angelo Dureghello <angelo@kernel-space.org>, 
 Anshul Dalal <anshuld@ti.com>, David Lechner <dlechner@baylibre.com>,
 Daniel Palmer <daniel@thingy.jp>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Hai Pham <hai.pham.ud@renesas.com>, Johan Jonker <jbx6244@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Julien Stephan <jstephan@baylibre.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 01 Aug 2026 14:25:01 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785589691; x=1786194491;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=razj7EZVJj3fNiHDAmEq7ZK3Sy9uaDzE8S7aJTWTMxw=;
 b=IcdUGKpsx8/eoGggrMcmY11KEVSdQ0t1h4UwCggmZ4EYoujN5LxkBwP+CS5n6s7guq
 HfKkAao9hUCo1TQ2PeKEk9BJhP8x1SN5/ZRFBRgcoX9J7tkcnRw8yh7P9zgmE95BYiol
 QWArKOwQqk4bkl7YyAlfA9R3YyVQ6GxJ455gt7QdohG10f9DSBK/0KvL7d7/jvJT1SQn
 u6OU2AdrCFf7oD8VQ6M60RJLjvt+u+CbPxe5drXqOGPaFn68uNyZBNSEOudGrKhs0X9p
 EiwggcbKI1PU4i3LeWYWWcVIzzwxBcLXXp6adarbkhDYeel6vNTXT6hKZt4wgGl1ZGMP
 Mhjw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=IcdUGKps
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

On Sat, Aug 1, 2026 at 3:24=E2=80=AFAM Kumar, Udit <u-kumar1@ti.com> wrote:
>
> On 7/31/2026 10:03 PM, Ralph Siemsen wrote:
> > Prevent random memory writes from corrupting flash memory.
>
> my suggestion will be check first, why stray write are happening

This is purely defensive, there are no known stray writes occurring.

> > +static void cadence_qspi_apb_write_protect_enable(void *reg_base)
> > +{
> > +     writel(CQSPI_REG_WRPROT_ENABLE,
> > +            reg_base + CQSPI_REG_WRITE_PROTECT_CTRL);
> > +}
> > +
>
> I expect compilation warning on platform, which does not define
> CONFIG_CADENCE_QSPI_WRITE_PROTECT

Originally I used #ifdef around this code, but checkpatch complained.
I can add it back in.

Curiously, I do not see a warning (about unused function) when
CONFIG_CADENCE_QSPI_WRITE_PROTECT is not defined.

Regards,
Ralph
