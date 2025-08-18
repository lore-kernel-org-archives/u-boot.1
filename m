Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF6B6CA0EC0
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 10:31:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D79A830C0;
	Mon, 18 Aug 2025 12:31:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Y5WJVosh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1628B831BB; Mon, 18 Aug 2025 12:31:32 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02DED829E7
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 12:31:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3b9e4106460so3291942f8f.2
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 03:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755513088; x=1756117888; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J7miKttEl1TXzWWBmgsyycYYnWUL52pOeXqKJm+gtDY=;
 b=Y5WJVoshor8OUTFUO7uCySoRrhbAnPl9jVWTKvKLDc+njaQnASbltSC8O8IBfJ8fZr
 5crkXdgNDAc1DZTGoy2u3sMhpNWcnM66Y/aEQzLggESqj9brGWW6FbArIpXKGxXm+x1a
 InkJz81AQH9Nit3SfXknZyScX7JWA1//LI8TbHHCWmB4UeOzpKKSfkyJiIzYKi1jv45i
 aYQUiPqCxxh+v9xnaDpwz0g0MwyIntYaG1+fkYKb7zEvZUzbPLv1+/uDhZa1mGilogvS
 RyaIYVCZ5CIi6upaL02S2x6wVGxjDKf7Jg8xqotRf1PKBd74etddC0MJIBGiJPo7ZcTk
 5OAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755513088; x=1756117888;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J7miKttEl1TXzWWBmgsyycYYnWUL52pOeXqKJm+gtDY=;
 b=nSXJ7q1UVVZkOs0rmf+7hWHsn6iP8Dht3i8b0SdVgi2/JMEVmysDWWwn2RmfUK7+y/
 jAn7DV7LamS19iyquNNVXuB31Rjo2HAcCu1OIMfIRYiS8y6JXrppWXP5H3Du79IXYQ3k
 WlpmbA0u/8+o1to3e5b0f5t/Mi61NWiQVF8cbLWrMV9/RwLBtCARuC5BhZqUK+CtO4z4
 VL2P05YMwraK8BliOh8z6qYtbRxL4AZv05/NCWYbOMdC6eT+Y+uEtf6rIJ5or1moeCqI
 crYJTHgqSUzYqbe6o1E2FZV/kcgB3Zm8LrBme7Hn8gqV20AraP+gMcT2ftDdhThN//IQ
 JPGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP/5yq9U/LGZXdLZC5w/cGBtMnJSezIkC4YTHkVV4WdSw4V4Tf9wINMPVdTzNMFiwQj389WEk=@lists.denx.de
X-Gm-Message-State: AOJu0YzUt5tvzwbPgmsnmrLGglSwqlT6mct5Ggt4BbnhosUdpU6FTryq
 dsQ+6318mL2CbOxjWl4qjMeeGzTs2SjSIUzFPJkYhcBhp0EpYr2k9P+N3zN+lpogwco=
X-Gm-Gg: ASbGnctqS4DJH9+S/sRQ0wQQWw6BfLobCbsxUycH2qZZHoi1V9vVtPi8cm5qBE9i7ee
 T9ZZA8U9JYd6CkprT6TK25TaqsfvtJKK+b7pEhaMH5b3HGQ78W4MimrJ4PFJHdV0XdFlUP0nu3w
 izEWCsxv26Y+dHceIKSVddzRGAb+DVJaFuLIS9oiQie6R3w6GFZCMypz+c3TbEKVRERPeN6hnQ+
 ZNppggEgEFHzUcvoWfbv4+hnQmR6Jrrd67pr8idzgwuIl6vL533cxdNaOsZ4QE0xLXocHsVT1ue
 0kcDhy3RTsWAaKlpSOEG1fapBcGpdzYhFx58RczVI8RRwc+d++tVIWJBzf0HeW2havkr4ulB50Y
 Xlt3z2A8uj7gsIQNFYUs8wzENJpZDVThrYWbUiatUDmtXa09l+RaN9PZfEjRoH9mbEYY=
X-Google-Smtp-Source: AGHT+IFhnudlEYq4OSTsNwQBzqEvDABi8UvAKEGrd9o0OqCq98ND9qf/Ix3yX9Q642/rdjOLVFPV/A==
X-Received: by 2002:a05:6000:402b:b0:3b8:ebbe:1792 with SMTP id
 ffacd0b85a97d-3bb6694335cmr8262984f8f.10.1755513088297; 
 Mon, 18 Aug 2025 03:31:28 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd6f.dip0.t-ipconnect.de.
 [79.195.221.111]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1c76e9basm172438035e9.21.2025.08.18.03.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 03:31:27 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20250806-phy_qcom_snps-v1-1-5cda830026c7@linaro.org>
References: <20250806-phy_qcom_snps-v1-1-5cda830026c7@linaro.org>
Subject: Re: [PATCH] phy: qcom: Fix ret is uninitialised
Message-Id: <175551308710.842888.2215594823979505421.b4-ty@linaro.org>
Date: Mon, 18 Aug 2025 12:31:27 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev
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


On Wed, 06 Aug 2025 17:55:04 +0100, Andrew Goodbody wrote:
> In qcom_snps_eusb2_phy_probe after the call to devm_clk_get if an error
> is found then ret is printed but has not been assigned to by the code.
> Decode the error from the pointer and assign it to ret.
> 
> This issue was found by Smatch.
> 
> 
> [...]

Applied, thanks!

[1/1] phy: qcom: Fix ret is uninitialised
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/fda7bee6468e

Best regards,
-- 
// Caleb (they/them)


