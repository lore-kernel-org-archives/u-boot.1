Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49938C43327
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 08:14:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A68E84CBB;
	Thu,  2 Jul 2026 10:14:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VDYUYPCo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1275584CBF; Thu,  2 Jul 2026 10:14:39 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 660E184CEA
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 10:14:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-698aa75d15dso922729a12.2
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 01:14:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782980067; cv=none;
 d=google.com; s=arc-20260327;
 b=go6/cT9WHbKKp0YaUysUzuHCIV383zAVfV5ZxWry/TCgYH+utJUUoz6zW3fUR5xYy4
 Zzsg1fEKegVU33hL1DMdOxosRO1jWHtsvruVfBHWRQ9graTpCdgWHBT9+7XiJKaI25vU
 UUdW3XY49pzYuivgztnxqaDSsfiKiV6PRPtg3fT3i74QkVpHnGD7nzjIya0gY7jo85cd
 ntlHUQcSrVDArzOYUyJWrZ4vSJtH/6PEQKsikuIDsUJCCP9pt6m1eFDJSR6+xETB1Kse
 IlboSXMUYCJler0q0z4lTZuLkbVHRXgYJOzukFWiVTqDJK2764U1sEUYyM2Q9DNd7O1Y
 NlNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rDfTgoYdLFGuZTlQ1tOVue/RZkRFpXq+L6aiEdmBN6U=;
 fh=LNzFrO3x4ja7y8VIEf3TUbrT4J7d+qKtvjb5Ne2aQZE=;
 b=NQTnI+QqPpE6forY15d1pFUIK+47Cwkb7TWqQvZY1fNY9UgpnwIgaK+aBUZvH09dS2
 Rd7YugyxN35hCutUsEGBPujZGKkttZ9fb6xgfiCgse0lyk3jv+dlkW2rLC7ITFZ00iz9
 NLTGqF7zHV1ntWsUFNvg81PKXXBtIwJJth9BloKOSOr7wHhpYi6maEF5T/5yY8GNLviK
 CpqU5yPmAsW6wpXmNoGRb3jpkBQ3VEEoSC1j13yBvwD/GuEe577IDS0afcuP6IZ6Gup9
 Q59su2JzQMXyedqD/uVXlZw7fJIJr7nFEelq3NvgOILwG0lYLvnAyygAAYHvTOf7t7tr
 X38w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782980067; x=1783584867; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rDfTgoYdLFGuZTlQ1tOVue/RZkRFpXq+L6aiEdmBN6U=;
 b=VDYUYPCojg6w9hhP5+CYcTIVWynaYNzE5g6oXs9uAY5I89aGa4dT0Gqn4gH9BQF23P
 WyG82donWT8IpH+lTk75V92fNYjgqCkPn4rsFGnBI2GXoA0FnN4kUZHKE6+qmRTP2gL5
 S+NiFLuUj0EteaeZnCgM7zv+uYXDAoUV4SNYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782980067; x=1783584867;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rDfTgoYdLFGuZTlQ1tOVue/RZkRFpXq+L6aiEdmBN6U=;
 b=fUMg1ZgsBoRiHUqIPVHMDGxEiLv0LVgb3VOA4Rk7zIHjZkMgelAGt3zKFPcW8k6R2P
 UDKM2ZNAHycxoACtsSSQpqJhjALnqQPxmCmVVCweW0ZEAIChCCIhQ4u0PLd90tGPr8u4
 COcsjtJvJZH0a8vTSemHAIiMkN+vAnttrVK+r53lkC1VqnJGIA4HNn9oxMDRazEzVRuB
 Qsdhia1WnFFhR6E3vxVrn00xfFD5C87tDNa34lTPQJDTwCsSsCp2RMNIMLS5hiFn0uxZ
 Te62wPku2DY1gMS68jQg8uLVUOivBwcUYH0mBQGbdo9/B2QuMhsYkis2Q9wVfdEwwuXi
 7UrA==
X-Gm-Message-State: AOJu0Ywuf1P3V6eplz4pn5gKZIJWNnSJMQmRavwKuT1e/RBKPEzmW6f3
 lXk4axBE70I57P7lyUk0GcELRQVYlh2/gusV6nLyfMmHLmeqU2S7MLnUx/3pfMyD/iMK4k7in26
 GsjVdXMJseeEpccWtnqqvytaThqzde8nd1YB8BM7Y
X-Gm-Gg: AfdE7clRUNkwSdIAY6EAXW2MxqCdZIa+LZOwKXMVUGY7dBS+J6JDKNkbJySqKmlSQOv
 t9b2Weoc/2rV0wfYgmFkpK2ac4jgBHQjENnCBIey4M+SCKBgWDgKJgEGI5crhcwwUmpo3aQHX8G
 fDMtLjQhZrVZ1r/p2F7tzlaW1c4ek6ba66PY6zoT7uBBeXWai/BK/x6afz3gJ8TOCwc444jwlVo
 kGPzrFbXnBKOnfm3woXwR3Ps/IVdFe4hHMJMhEI8N1975CNAW4bJzDv3iMJ5XIhFDAPH6Rp0Q==
X-Received: by 2002:a05:6402:440f:b0:698:3b7c:7e2e with SMTP id
 4fb4d7f45d1cf-6989f3940afmr2521216a12.38.1782980066866; Thu, 02 Jul 2026
 01:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com>
In-Reply-To: <20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 09:14:09 +0100
X-Gm-Features: AVVi8CcfuXcVPUiInPadTWTVjYk9QxMLcis4WhIChkaI8i5MupQ_1Q1Pqhsihlg
Message-ID: <CAFLszTjokVGPr8_GPm_Ud-h97_Va8T7MjhJc64mr4R1i3sZ9GQ@mail.gmail.com>
Subject: Re: [v6,00/11] Qualcomm IPQ5210 SoC bringup
To: varadarajan.narayanan@oss.qualcomm.com
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Varadarajan,

On 2026-06-23T06:47:53, Varadarajan Narayanan
<varadarajan.narayanan@oss.qualcomm.com> wrote:

> Working features, as tested on RDP504:
>     * Serial console
>     * UART

Just to mention again that these are the same thing.

Regards,
Simon
