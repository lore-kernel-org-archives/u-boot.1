Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32050C982E7
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 18:06:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC39D83B71;
	Fri, 16 Jan 2026 19:03:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UBSOEEA3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 502FD83B71; Fri, 16 Jan 2026 19:03:35 +0100 (CET)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0EE683942
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 19:03:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x544.google.com with SMTP id
 4fb4d7f45d1cf-64b608ffca7so3605457a12.3
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 10:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768586612; x=1769191412; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k0zaX6DczL6blx5STGpgujzRCc1kEL+kr2tqm49frW0=;
 b=UBSOEEA3rJFGL3Xr1S+RHWBu9mR4/wl85A7rGbcbUWyPxT7m5Gw7KgVmLPJnqg5rPg
 sTKUfnR2jSkPvNPF3oEUVjqJUl2BOv7A9Ua7Fqqu59VZ/HenxnSujcnxXhuWppKBere/
 cp8jQItRFIw2wJrOtcvDMEhWbIrJHcQ2nfpivVVpxaGnf7GydPCjsqP6fD3jYHESu87S
 LjLMW4mEYxOSDg5ZeUUjl2oThAv3G98mLQRhvwSerhoo7LKaOZi2yC81tbWJOIISGdjE
 8fCJA5lsXPTszy58bfMTLCYPijMXOBWjc+ZZlqnTlK+h0aeoSuDerHmc9e6hxLaHr1yT
 U5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768586612; x=1769191412;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k0zaX6DczL6blx5STGpgujzRCc1kEL+kr2tqm49frW0=;
 b=M1yFjrcZNPsCg4CnM5vlSoDJJEpUha1XhrIullYGeSva+JuQFy4f5cDQOVpgOeZd3M
 ZA2R9TfAOyzRxNWMGKpOYfYUR0DkEv7hJIE3PEEHP449A6MlZKlaroj2svmfGEhdxRDq
 4coA0lIH8iuH7YCDcru7juGeabg+kw1DLYE/7N+vH/YEhXPJtl73q4ePquIXfEEEcWrP
 fASF/7VAbE7RPk1iSboqG9+FHY6cjJpffFQxpXzLXKVUYSC8ht6zAVSc9QIFJd4rU7rE
 tvZZhmMjtprHxsWWf6Ado0aX9D2dCm0d6JqLnePl++a5g6d3QdjQHvNe822imBd42Mr1
 au7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAPtHgAJO54OhYT2X1zGnp8VZTueDG0AFBad7qO0A/Yala7Yu1xT6yLOM01H4+3f9p7GFFo8s=@lists.denx.de
X-Gm-Message-State: AOJu0YyXDD+kkj5j/Z2ewGOL1Cm31zz7lyECZ1zr7E11s0WLRux0Cci/
 g8Z8Y/NFKiC+miXq6nkOfHnbmoxsb4ss8O2S5SMqzVMUBzdSG79DBmtMSRy+k0BV1xw=
X-Gm-Gg: AY/fxX78bhwlOSVID1JASz1ruDWq2Mw2qyIZX3hTFjwE+yFpHtHfnMXMjRTAjSVzEiR
 cFbT0m3cTVWeBsu4kKoTythxGh38VLjKQU1Oi0zOUkpIoAXaSWUIvSs7u/qgCMGw9voaOydXhxb
 G3zpg66AFEvlGNYqv1W5vnQIw12spe+GnApWfdG4TAzFHAcjvOP1Z4R2rP1N/Sy16KE8i/MlmS6
 aP0Ji2340ghzwMbzR8SES3F89r10IswhL1rjvyJ/2qF9a2PFIr85ZAvzBAOoWEng5A3Ajht+mtq
 gdPR0fnTsU+qYhLwGcep6WMOXfW7HaiEdP9QdmpBdj4RXPEzqmvGkFXu1gxTEx3tvQXN+Ta0Wpc
 g3tpMz1as7DFomIh65m3udI6rMUMkXRu1bJPAMjXBEUC79Qn9MFOc1t5eDLo6oN17ty6ivc3amh
 rVVxtDKHxWvKKRt8nrEFZCxM8S/0qnPCd4gyjmPx1gwclyYgrk4nr2mw==
X-Received: by 2002:a05:6402:2808:b0:650:8563:fdbe with SMTP id
 4fb4d7f45d1cf-654bb4296d1mr2607911a12.23.1768586612342; 
 Fri, 16 Jan 2026 10:03:32 -0800 (PST)
Received: from lion.localdomain (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654533cc5e1sm2932712a12.19.2026.01.16.10.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 10:03:31 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
To: Heiko Schocher <hs@nabladev.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20260108195301.3159260-1-casey.connolly@linaro.org>
References: <20260108195301.3159260-1-casey.connolly@linaro.org>
Subject: Re: [PATCH] i2c: geni: bail when clocks can't be enabled
Message-Id: <176858661122.3399278.240676332307316402.b4-ty@linaro.org>
Date: Fri, 16 Jan 2026 19:03:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
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


On Thu, 08 Jan 2026 20:52:55 +0100, Casey Connolly wrote:
> Failing to enable clocks will lead to bus hangs and the board crashing
> in some cases, let's actually deal with this error and fail probe rather than hoping the clocks are already enabled.
> 
> 

Applied, thanks!

[1/1] i2c: geni: bail when clocks can't be enabled
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/d38ec14953eb

Best regards,
-- 
// Casey (she/they)


