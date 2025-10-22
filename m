Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31B7CCD195
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 07:32:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1959983303;
	Wed, 22 Oct 2025 09:32:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OW8U/KO4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54EF6833F6; Wed, 22 Oct 2025 09:32:21 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12E65832BC
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 09:32:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47117f92e32so42973205e9.1
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 00:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761118338; x=1761723138; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WRKG4iHqF9lsm0PJuiQ15QAg+LxrjKGxJqLCUfa9Kso=;
 b=OW8U/KO4t0ndnytpt2qUtDKrrh7Q2tPEbIVBnhBnMStphkmU+VnTaqifX3aIM9Qzu3
 RaV/vuhAE9EBtSDspxNQ5DIf92DvzL95vLrVAOgsYzrtLiXvuTbMNAKHoI8MTL1GMOvB
 O+Ak0YODPLJJSq02EQLd0tOeCCCnjiqwTXUD8FwNoIQMLx0qx/g2U/5MqfR+j+LuYm0M
 TljVBvJ9LNLV3AH4Hlhi5FHwIBFFh/Puz6ztGa5eoRWoxK4FKQxWi1mDWlBkg+J8jiyQ
 FIhfjMcQiVgX1EHJIVkkGR+9UtsBN0VJ6L9jM1spYJFlF2A79RzuowZR9LWcKDrRjk17
 /9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761118338; x=1761723138;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WRKG4iHqF9lsm0PJuiQ15QAg+LxrjKGxJqLCUfa9Kso=;
 b=Ru3YSQ/fJH8HND4jPFalMM7TrzSC/IuKL9GuXozoQvaixgEYJNAQcF0npoABrW2OfV
 Uvke4CltTPe3PI6667A0t1EiLYeoLhbf8NcodrTsL8IISoVF87tH+ZjByxArelwsBw/L
 /vjx2oaBL0WbX0w1JG5oLgIUWXAcPB7gkR/kI1F07JKL/ZeF/SkmVZgfEk6LnJNlvhym
 SwPJY4WL3DQNX/tiGok2dySiZAWtGqDtC2YS6RhvT3Wivg6phHvnoCIZ7CFg0qd98C83
 Bfhbe+r+QvAwOl+U7AoxnlQ9nimAk573B9hd/tgpmAsPvgABX5HM45of2bKvF76aKL3q
 o2zA==
X-Gm-Message-State: AOJu0YzADco7gvuF29bjV/qJeN7JtrNutZPk8bUXZNHjAlcTb8TVEDFK
 vii2eNoXOMNQQMbXDUA9lSS76i9bJyh07ofpRb5yubnUxDvUyrHJCfVi2SXmURik3EY=
X-Gm-Gg: ASbGncvhHLYpcrWstWoEoFxPLq8nMpODz3gs4zV+KnulTFDsMfYFA/B5l4q5Fjs6hOQ
 EcIXwH2AglrzLlrgURRT7kzAMaKiUwKyIUFZn/JS2Pjvj9SVUTniKzXTgLure2h6/ST4u8I9MlY
 y9csefxUOUbH5d5UxdGXAji9J50RAKRKzE997Sf+qmvJ8ryxY1GTqT2gN8RQCGuMmX3eJi1j3uP
 jdhoYl3snpaCC1CtgnyAQn9i4fj2FtiQDERSXBegmTTtn0X9j8kkk9UgLloxROZWHBU5kXR3+iv
 qt/9HBC/RYVZyCqtQdcZdVOy1QziY7C/+0uw2yPd/ttZV4uiGXDA4aLVfFjcgzq56Q4pL68e86S
 7KG3+BXc0imdjhUkTmUDUEvaqN+Q1GJCZoFLHwRLT5+G+ScunC/ImKfPFLPgs9crzQLoELEIuQ0
 kJORKUecoch2FsEH5vZj1J7o5+P44mi9nJd0LUrM/cquQiEz2O4A==
X-Google-Smtp-Source: AGHT+IHutfrw3YwEBDthIz7mrroQCIhIWTL1rJDv4g83zQUhu/Bm2cIlloID/yVjfv5s21oQC1BHqA==
X-Received: by 2002:a05:600c:8b66:b0:46e:32f7:98fc with SMTP id
 5b1f17b1804b1-47117911ac7mr141728485e9.21.1761118338475; 
 Wed, 22 Oct 2025 00:32:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:ed50:db7:290:9079?
 ([2a01:e0a:3cb:7bb0:ed50:db7:290:9079])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c428ece8sm30974515e9.7.2025.10.22.00.32.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 00:32:18 -0700 (PDT)
Message-ID: <85729a06-d692-4392-a2d8-295b028f91fe@linaro.org>
Date: Wed, 22 Oct 2025 09:32:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] bootstd: make it possible to use tftp for netboot with
 standardboot
To: Benjamin Hahn <B.Hahn@phytec.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Martin Schwan <m.schwan@phytec.de>,
 upstream@lists.phytec.de
References: <20251021-ip_dyn_bootstd-v4-1-1452ad40ab0c@phytec.de>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20251021-ip_dyn_bootstd-v4-1-1452ad40ab0c@phytec.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Benjamin,

On 10/21/25 16:34, Benjamin Hahn wrote:
> Add the option to load the bootscript with the tftp command (static IP)
> instead of the dhcp command (dynamic IP). For this a new function
> tftpb_run similar to dhcp_run, is needed. The selection of which command
> to use can be done with the ip_dyn environment variable, which can be
> set to yes or no. The ip_dyn variable was chosen as it is already in use
> on the imx platforms.
> Also edit the bootstd doc.
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
> ---
> Changes in v4:
> - moved tftpb_run to net-common
> - depends on: https://lore.kernel.org/u-boot/20251009123034.2441110-1-jerome.forissier@linaro.org/

FYI, I have that patch in my queue for Tom, and I plan to send a pull
request shortly.

-- 
Jerome
