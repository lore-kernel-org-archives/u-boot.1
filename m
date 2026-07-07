Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9344AC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 19:43:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE27A8497A;
	Tue,  7 Jul 2026 21:43:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fKRGfvfK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89D398498B; Tue,  7 Jul 2026 21:43:12 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D34CE80433
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 21:43:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ralph.siemsen@linaro.org
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-92e501244f5so215171485a.1
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 12:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783453389; x=1784058189; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RDtmXvD//RHOLcqM+TpazNjaKtF+qcnoxA5U2azvwLk=;
 b=fKRGfvfKKrWKGReo06yfw2w/kMkxMPOnlEZ+euJ89tSuSbsatGbvGsrymyyIEiYDxL
 FA0JOGjS99Zqp43jNi5hWJWvMC9A14Zo83RbREzK2nsWoCKAfvOm/johT/B9/I4VMjQZ
 I7PLwJFk+Ue1Q12ralPd4cpbAUPs2AnEeBQBz1h/BPI9CBd0RV7Od9XeiPO4zUrTOD+l
 PDrEfpAIyDkoi2KOGC1S7ybzhMJwVw+28w7iv1HdKrBt24xRhAdHE/jS6jg6hCmqhbwk
 d5+yapvGgFhfTVtTcdMLk7lFR0PACeoFiFTI8Ty6N1dSncbqLosodg0OmDTZxuII6Ebv
 +/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783453389; x=1784058189;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RDtmXvD//RHOLcqM+TpazNjaKtF+qcnoxA5U2azvwLk=;
 b=B8eR8SYOS6b1+lzSer80Ij4UlP49Bi6Xe3f0525p0V+hcbp1fND7/5an7FIKzAfoH5
 jBADYOLzMuJ6MVzmdWGeBS42O7qZ5p4V58nlq8UhUDi7d2Jq8UGXNWCRhPXq7bdrCNju
 tbHRbqUovivzKXy8wVamxVM0UkxW5FvcTOuvvkriWanDJqJ0mBJOy5Q8vN792rPrVEYM
 mxS1zSQ3YjNAs8ISW6PaZlM6sC6IMb+U8bfT9xf5TcQ/v+8d8M01jj2a60xsJNBqhsal
 93DAA5X5Y1Eo0+Erk4y5IqQbraKcoI4NhR7zGjeKfSVukaH/AUYTrS/62XZqIJ95ryDx
 aK3g==
X-Gm-Message-State: AOJu0YwL5ICD5cXvo8Oapt1xiEQ7eNX2D90F6lzo3LlObMcsm5Wr4/sf
 DmQDw4Wi5BZMRpJ4mMgp0avSPqpqha4ys+RaNXDRJBeNHzuXAH55zhfXBKnEhVKF6e0=
X-Gm-Gg: AfdE7clKVvDUpFY1IEBsUR8VRP1Rdpb6iOOAjXUpcA45toF6KL5r/mPkmxTwQuPlyb9
 TI7dVAv+QA6QJu4ONLeZ6xCjPAofM+xRSvJ85qNerN2u/Wm8ZGrixzLNgYuoLRhanCIb7da3gi4
 /aKDKRfxmEI61W5IVsR1VcMzo6Fd25wTuITL6YBP4sL5t2tNmhMEvFba3mzZj8v8rikK29SiXgu
 tsluDKr7PLzRjeeMxRj6sDTCMtdbptKljmJaZJ8869B5W3jNEZ0zs4tiNkmrUJP+WA+ba5+FZAu
 epJQdn1kXhohjsl6BNk2FNjfAIgS27l5dybqraF7OUMbfduHCCdf+oR0UhyRlfnI3tHONDG/b0v
 KN4WG0KZMZDG5UZev8TWk6vYLHhSsDFX4+EmB9Rbx2OTDTAW8CwiBmp9IHjV08gP1LkWUkqrn4U
 3AtwMGjGCEQ22HpbsDhboKAiNxNPOdR5xQ/WmGvwXHp3Q1JeW13yCB4gcPRIz+U9w0P0dw4G3kL
 CPubI01CQ==
X-Received: by 2002:a05:620a:199d:b0:92e:c116:bef6 with SMTP id
 af79cd13be357-92ec116c3fbmr426104085a.83.1783453387604; 
 Tue, 07 Jul 2026 12:43:07 -0700 (PDT)
Received: from localhost ([198.58.133.142]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e90ccdf8dsm1240440285a.37.2026.07.07.12.43.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 12:43:07 -0700 (PDT)
Date: Tue, 7 Jul 2026 15:43:01 -0400
From: Ralph Siemsen <ralph.siemsen@linaro.org>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kever Yang <kever.yang@rock-chips.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 David Lechner <dlechner@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH v2 2/2] usb: gadget: Add Renesas RZ/N1 USBF controller
 support
Message-ID: <ak1WxStgv_6HtXkV@maple.netwinder.org>
References: <20260702-rzn1-usbf-v2-0-00ceecebaea6@bootlin.com>
 <20260702-rzn1-usbf-v2-2-00ceecebaea6@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260702-rzn1-usbf-v2-2-00ceecebaea6@bootlin.com>
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

On Thu, Jul 02, 2026 at 10:11:09AM +0200, Romain Gantois wrote:
>From: Herve Codina <herve.codina@bootlin.com>
>
>Add support for the Renesas USBF controller. This is an USB2.0 UDC
>controller available in the RZ/N1 SoC.
>
>This driver was originally written by Hervé Codina for the Linux kernel.
>Suspend/resume features have been removed in this U-Boot port.
>
>Linux revision this was ported from:
>
>74851fbb6d64 usb: gadget: renesas_usbf: Handle devm_pm_runtime_...
>
>Signed-off-by: Herve Codina <herve.codina@bootlin.com>
>Co-developed-by: Romain Gantois (Schneider Electric) <romain.gantois@bootlin.com>
>Signed-off-by: Romain Gantois (Schneider Electric) <romain.gantois@bootlin.com>

I've performed functional testing with this driver, admittedly on the 
exact same hardware that Romain and Herve are using. With the 
corresponding configuration options enabled, both DFU and fastboot 
protocols operate successfully over the USB interface.

Tested-by: Ralph Siemsen <ralph.siemsen@linaro.org>

Regards,
Ralph
