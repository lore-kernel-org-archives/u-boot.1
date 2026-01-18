Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB8FCA5FEB
	for <u-boot@archiver.kernel.org>; Sun, 18 Jan 2026 01:46:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8496D83956;
	Sun, 18 Jan 2026 02:46:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VaAuckYC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5F1683980; Sun, 18 Jan 2026 02:46:24 +0100 (CET)
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6D2280FA1
 for <u-boot@lists.denx.de>; Sun, 18 Jan 2026 02:46:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-6447743ce90so2844066d50.2
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 17:46:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768700782; cv=none;
 d=google.com; s=arc-20240605;
 b=AxIxuSXKYUOCrg858GGWT1LlSyoaIfZBMVDO17alzR9ZN1fp6fxOxtJ79lasIjqxlK
 ih4qQnViAgsqT17OUkIFwXEgopH3f6pFCQnIhKMS2BD8WL+czCJPrTGTwZTJOAMwBdaO
 FWKdJGaGss2TRH2vlNRfFYwVFabzZovhjXTvz8ibW8tX/N8f+ubzTXhGY6g5gW0Am98G
 v2iesl4UqZ1yiM+51Y6TTceaVAPpE8X93Qy7ovCB27bV3YnM2YaAAlxizGowZfS/fVw5
 D4OWlSGxWZuaKdUymvLZkDowUM8VUTFLA94sJchZ4EythX/1gS1q7G1Sp5pRefuTHhxc
 oX9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=f2Kq/XxLL4UyGYP3seGPVmI/TN1q7a/2tdV9h8ZQT8s=;
 fh=bz+zt52UcI6Ba/FOEfGBPsM1vONgU+2y6gq9iWTfdws=;
 b=JxjWnti1Au/MfATHPXj5xTAHZxiXnUj1I+0HwRBHitwP4Cstp0NtgNP8RrsNJtULCQ
 09jHHg2jakdX+pM2py64wqX896wjXfr81BkXk90cD/fNNLiVmgucr3fovbpyw+f9AThL
 B5vC8GN18ppRVWNgp5CLcY6DKe8VluLwFZFIpCqk8mIzi5H8K8doz7dVqERzzsPoEeF/
 xQHqiwZfxO4bv2pSNIX9bfnXxcZmZJwvGtcn/Mt8YIcCFzrGUZVgBj/xs1Zv762gWVXN
 SJTaV/sHQz+PCKJH50Hp/ox+8Q6ZjSpQli8+JFkNgxYDer5eQA4RSt8VJ97g1vPdhXcH
 t1aw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768700782; x=1769305582; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f2Kq/XxLL4UyGYP3seGPVmI/TN1q7a/2tdV9h8ZQT8s=;
 b=VaAuckYC9o9rTo8haIYubX7JFHAj/Ka16UUIAxMBh6cB3bTx1EBCdvclE7nlbOUNm9
 JqzGeCNkTi2GMPLEWn+I/UoTalyAU7aQKICWf1z0b/v3iz7IR7CxYqLX32Ph7U/0Oj5K
 W2HyO89VklWNd1msGUm2h2gDkMdxM1OzRznsuIV5OYysI9nlomF2uLHyjt2G6qqWGLhr
 F92LGbf2U9A0xL/+pDWNPuKCjOSRYRMJdis5SZF9BwPdd/UN/Py8+mr1h5OMhWm3eryF
 InjC1M3NTa2nFqUpQpQkXX9VCNvYI0Rl+EqPv2RFL6Oc8YVxh7Uc2tbdAPraP/4hziPP
 CogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768700782; x=1769305582;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f2Kq/XxLL4UyGYP3seGPVmI/TN1q7a/2tdV9h8ZQT8s=;
 b=tV/d9137nWLfQkL/ZVRcI77jSnPbc0FAz5XY+jKNnct5guPKuseDj7BUb55l91GTmt
 dKrUJ578takO0pF6gcK0b4LvjFjyltGPX/DK+e3Gl40e85c3uRiFFgLnZeaDFm1B+1KW
 /Fv/zkIRUHtRMB3zDZGcUcHycvpxJjyqS+rDF9fOU2bvoJSrfieZl/ZF5OKub/xrEyrJ
 7fH2PDF8ku+x59yQ34abIYw8b1O9ELPPzPMUNrAOEECZXDUV1C51WmUiLyy/ZQ0voPTk
 X2LoYgogp+lQb8VZ8JlFPa5JtuYxzQwlc6eobOzKULRKFsFNltgDNoa0AXs2Afwgv/g3
 3/5Q==
X-Gm-Message-State: AOJu0YwmaaWNoXgS+Erfyb0xbPUJkLJIA2LXd4/F+CKsecTGYSX3lL4P
 JtbYa5hJFHyuWGmNNxmEyYRtlxuzefXb/u2mm+n8NccIN2r5n8U5XXgz1J8uKLEt+CxrQIRVAZZ
 /xgCLR0xjgA+8mrwUAXhXO7f5igy9mbnk0g==
X-Gm-Gg: AY/fxX5afOdsc1z27RQJj+4laEII2IZJ7LT1PdmQffOzQsjmckYEC5dJSAoaEWtQq+0
 yZcOBIwNxgGJSld9N0wEveoszfHsSgVljgxEg+cpsudWLrS3izJyes/dz94PshzP9FBZR3BRCEP
 fihOdASoBET0NLHkmkUoDkjYERzKZd3FI4YJj63OkjKTGFa2i2zdQ/CZOQmm/d0sYsg9GUfwlhP
 vu95FNDo/Ig8tz2OIMHupw38gt/g7vxlsc+kZ1Q3VDxhPZ8dNAI9zwzxzhAClBP3iEJ2AEobj0p
 WWbhc738
X-Received: by 2002:a05:690e:12c3:b0:644:4e03:89fd with SMTP id
 956f58d0204a3-6491647e752mr6911564d50.16.1768700781730; Sat, 17 Jan 2026
 17:46:21 -0800 (PST)
MIME-Version: 1.0
References: <20260110203433.715468-1-marex@nabladev.com>
In-Reply-To: <20260110203433.715468-1-marex@nabladev.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 17 Jan 2026 22:46:09 -0300
X-Gm-Features: AZwV_QiejEZO9AiIkw-SSaOGq2VIKZ044U9ey39lxh4YpSXfBSRlXi7wY5EyTtI
Message-ID: <CAOMZO5AQiYpHw7Sq99qQHzBdiQurLD56AC9tz2+iHwTnh=G9dA@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Enable boot from both USB controllers on all
 i.MX6 DHSOM
To: Marek Vasut <marex@nabladev.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, Jan 10, 2026 at 5:34=E2=80=AFPM Marek Vasut <marex@nabladev.com> wr=
ote:
>
> Enable boot from both USB controller 0 and 1 on all i.MX6 DHSOM.
>
> Signed-off-by: Marek Vasut <marex@nabladev.com>

Applied, thanks.
