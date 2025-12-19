Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1E9E66895
	for <u-boot@archiver.kernel.org>; Fri, 19 Dec 2025 21:41:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E32A803F5;
	Fri, 19 Dec 2025 22:41:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Rn9zMnRX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0618808AF; Fri, 19 Dec 2025 22:41:21 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7853580050
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 22:41:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-4510974a6bbso808428b6e.3
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 13:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766180478; x=1766785278; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nVekJ/UbZQM+N3Kw0a1dhYGs5YWGsRYPRvu9Cd5N4Gc=;
 b=Rn9zMnRXanjlsll4ZTqVpIrgApa2pDvMMONYS66GoFSVFJlIIkprWaJzPJ7+CSyx4y
 B9wkXnZFiFF2Z7ZC63xjgC4nf54SO4Zuydm5rGd2nv8ZS2RUomPrboR7CJjD1saZc1eT
 eCn56hy85ayD+6J+A0EcgEZM/+sEOzbAUzrFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766180478; x=1766785278;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nVekJ/UbZQM+N3Kw0a1dhYGs5YWGsRYPRvu9Cd5N4Gc=;
 b=bsIlgHxwVYL9CQdMvy6JCDg2NCoQsw3ClJKeOHPKM9wttH9ba07zUL44pDmPlsyizp
 d21cAHUqzjZOY/67INLPGloDmRyiKgCm9e5Vqt7crYflPTCcSOP3NyepDscj2EZRsqie
 6iOrA1TeNLsyGm010uomWnzzL80T0ckVi541cFnaLw1w1lQT1j0um8nrYBe6w3EBvvAi
 EgF95TM5xtwVqBjchzdW3/3BayWVM5r5jxFXumNoeaJ1Wna0nRfUVH5flcJnnLPNX3wA
 DqnI4BdnLjT5ZwoKbP9wKvAiazTXwH3OMFccR8/5tvr+pGGZoo28ONw0j0hbpQtHw3Aa
 3Xqg==
X-Gm-Message-State: AOJu0YxOHOVYc7ZZ5CYBiFzY25L9kWo0T5wIhm2fTfRpWqT4SbaiC4Dj
 qXntfJOB45T58z4b3klK8x1EI+mo2E7L/kTMpF86LIcuabmE6gmDKgcnA+fICJ+WJRWTA6vf3X2
 5GvFXWSA=
X-Gm-Gg: AY/fxX5bpHnn9Lzb+6it0vpE/9U4xyu1uJmMZZF0yfIf5F1GfDUbCNjaPNxb1/lRXGF
 Yx5jZp38XjklywZp0iDeTxQxNwVJgLavVdAME1o0m+UAx2MRPmjjukVr1fF2AIdZkPezghetsqf
 R6F6k+Lnzg/+nH7sSdWzBetXqROEPF/i0oPKJkloPWmJSzYihK6+Aur8qr7Q9URx5Elkybj9Ytm
 P3kDitJRtKVvWy4AmNkjW5JQMTJm7ReJr9uZSIwTfiWw7eQ8NN9rq5kHZaOm4XdFI1IU3zpy0ts
 JrHaaKke8a6TQ6q0AXx28aLksGFJVfqUa2/+tA1Nlq6Ntq316dfDAYwE+5/hyegtS6cIz2CxMBc
 +Xx/KdF7RwPEEtbHEZyU+tZQc7y0BluNjxO6vvQElaP7tCG2X6LUv4Rpaoxo5K2dh9ECS7DBT7M
 I52ipAC3audLAXGBjPHh4J0eUlFCxW1C+g+/4HH/S6VIMWqK5qRZUwEt1UsH54
X-Google-Smtp-Source: AGHT+IH9j7Q8USrPO83MywivPRLa4w9bA4q93TnIuJL2z/30HpVo4IsyBsCW565NMNs1vNGo7EchcQ==
X-Received: by 2002:a05:6808:1b0e:b0:450:7fc9:3709 with SMTP id
 5614622812f47-457b21d7b93mr1875248b6e.48.1766180478151; 
 Fri, 19 Dec 2025 13:41:18 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-457b3be2223sm1684487b6e.8.2025.12.19.13.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Dec 2025 13:41:17 -0800 (PST)
Date: Fri, 19 Dec 2025 15:41:15 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>
Subject: Updating U-Boot next branch to v6.18-dts
Message-ID: <20251219214115.GU303283@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MlXbDlkhG2B/PtLM"
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
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


--MlXbDlkhG2B/PtLM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

I'll be pushing an update to the v6.18-dts tag for dts/upstream shortly.
I want to note that the following was needed for qcm6490 qcom_qcs615
qcom_qcs8300 qcs9100 and qcom to build, and this is based on looking
over the delta from v6.17-dts to v6.18-dts and what similar platforms
did:
diff --git a/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi b/arch/arm/dts/qcs649=
0-rb3gen2-u-boot.dtsi
index fbe72595f5ac..8d4871135fa6 100644
--- a/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
+++ b/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
@@ -17,9 +17,8 @@
 	};
 };
=20
-&usb_1_dwc3 {
+&usb_1 {
 	dr_mode =3D "host";
-	/delete-property/ usb-role-switch;
 };
=20
 // RAM Entry 0 : Base 0x0080000000  Size 0x003A800000

--=20
Tom

--MlXbDlkhG2B/PtLM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaUXGdwAKCRAr4qD1Cr/k
CqgaAQCMK8LYKFLjqNsmcNu9anlPdkoquWk4TDp/6x+dJizeTAD5AWu4Vq2j7P91
FwQZ9J3W5BQLfBly1LqCEqPTtpxEdgM=
=BOYb
-----END PGP SIGNATURE-----

--MlXbDlkhG2B/PtLM--
