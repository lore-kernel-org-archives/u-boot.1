Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F73DCD6E4A
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 11:25:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 755FF83EF9;
	Wed,  3 Jun 2026 13:25:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NxzvNvrl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F1DB8469D; Wed,  3 Jun 2026 13:25:35 +0200 (CEST)
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com
 [IPv6:2607:f8b0:4864:20::b129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07596839A8
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 13:25:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-65ffefd8bd9so8067917d50.0
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 04:25:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780485932; cv=none;
 d=google.com; s=arc-20240605;
 b=eOpZQkG/9uUjAGGcXlbKaQSaH4HORmmgu1+abuKFc4hXyKRLL/WpRGPXQ/PIe4UROR
 iPQTqcwtf/J8uD9k9+3Bhu+grvJ8HHDv2XaT3fQ/6WTdmZv0he7pZVOwCjHeehkrnFhE
 brQZNTbsOdpFFNIgmYyiV/ETinTWbimOcicZ52A+6b3H0NQR/LaMJ6kv7gWm8s7tKOJu
 C4IpVfNL0FvLM82PxQN2r0HKbXc3RaEcd51J8xVwXiPCHVAr4vnk0fLBjHMHEpTQCUYa
 rhksivoN2IGBHoOASwWDqFYmVi95dNM1cVXyFC9aCTCd4DUTv39DIIuVkNwPRkXuulMY
 Kltg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=C2KjO1mGVsjQ63tqOiFk5QScuinTXMu1AWmdQ/tZRgg=;
 fh=qHuurAjEGyW7uZ8Zs7K1T/FS0N1C1Wfafc/5P8ZPdfY=;
 b=ic4pwfhJItPukibHwFTfUWQ2SZnVOdKHL8ImmiRBtXcnCH9rjIBFnnLTxzD2hsS/5s
 cBgfk76xqZkYez8MRh/XC73oht94zgykXBMC285YtwJ8ucqnIZzareiN1orEKaVLS6a/
 jjtld5BhWUUMFnkuzuU+gYitrXAZmJbVEEem/BjPbTmJKuY+hpiddmN9cHXs/M1Zs0CR
 sKmkeOnKPcIuLTjXd/Erd2TrEFulqHVsP52eFjHCsK7AC3/kIp/ICx+S1zgi1SLFZdnD
 /L6en84yKiTUm8D7fd4hB9+Nmzvd1kfK+VK+rbZjzHXdnMeS637sSkfIroNxtIvkZcNj
 puSw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780485932; x=1781090732; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C2KjO1mGVsjQ63tqOiFk5QScuinTXMu1AWmdQ/tZRgg=;
 b=NxzvNvrleJMbXF9KYxLcdZ9g9AJ1ZMkguCrXwExwTBR2Wz07r8IsG6q2F1Z27HeImN
 gd7l4Avh2xcE17WF2/66gO9iHscJagMRPyQj3k7ugkd+MiVLVGynser7ZkdVoeH9xkYX
 MsPotYgiKHzrdKNg5V+h8yWONen06kdqyE192A4eRlrDqfZN3+KHMqUlmp9M6PjQt2L7
 +bhww3IpWZ/4JR8hnmM8238H3M5Pro7Dl4dqdcjeMMu/IjASY6KQp/XaKt+lIvIHAKad
 1Sc71X7WeskB2Ux3iyKcqectM4QaPyY8DOVSn1H20aFQpLXZM1fD5UOimIRVA/sX+FeM
 y3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780485932; x=1781090732;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C2KjO1mGVsjQ63tqOiFk5QScuinTXMu1AWmdQ/tZRgg=;
 b=mvnt6gHPU1HA2E55JS12fe1IA7WLdM5P0w7otVffdguhA7XD9s95n1x75q+w/Q6EnT
 qPo7HrxzTwsmuUyN/Uyk54MbIQAsWsFXtpoqojGRGYZVF7OvLqElVfwCEEpoxQSKVv7F
 CumcNCv0LwCvMFB0LT1+1kC0bm1a/o5G3EdGQrWm0Rvjl/3Sl1R8EsLYIHPycmWR4Pve
 sMZi/e4Q72mZz6lfh89yykq8ZN2geBj0Jxjc/HvYSVwoL30KH6p4fxAnWHP8wZNTMXaw
 OTOe2q7dCPRnx5U74eEGfZipuEGjivqC2Fol2pQZ7mw6KRv3ZHfFyT8ILPwTGT/A8Eyr
 9+PA==
X-Gm-Message-State: AOJu0YwEGv5BLnVZSxLS0CjlVfVd4wy3QIGf8GVGlBJZGf+amlzPBM4L
 noDiwZlENW8m96jw2pYEJ4H8lf1k17eAi/xHV9nn1PXwiu7WJYTgafKQ+qk++6SH4MPYLm+GB8i
 NPouMeKc+h4OYFIBqDMWgkypABuH53TfgRLrVqf8PVg==
X-Gm-Gg: Acq92OGO0xNyH2VWQ/Js19kjlKpOVbFk0PLM7MoEnWMDoGOFWoYgoY6SMmiCM5kN/4k
 OBXJq+bGJ5XDqVrNcRPkHTiBlPBp1NZzdlfph80xuVlUrWQYyzk7umNb1ZF9la9XTb5fbB5/8i8
 QadeQBBWl8j/P8p2LGdG2zuIoCrWvQb14VcPJQTLu47dPBgf4URagCV62WJzWX3aPuKX59LCYmm
 imXlfsJse8Hu7ehgN5sEVofzi2N8aAXMJvZKge1+shNDg/952Z6MWRiUqaH5BYx3SkiB1wbhfg9
 AOPOaVO1ZXoLofn+yAxVuYCHTk/tpTirPRO/AtZpL2UXjkRFIOVHcAuXS8ZrpanNXtOFXeJnv23
 m/p7piPpWXtvtJYSV7KV0kw9iqOSfhxgjleXanyaBUjEmwyBg9kvfjNhn2g5yi0nf9Rx6MjhNpi
 CSLee8yjsGpPyc4aw62Se9ClRw+bovA7uQRdD/KFac4Ks8kjZBmyUhPOD/LE4VCZ1CZxr+wxvAi
 WnFfJot4h8s04+41GnV189eGzXuRVMebSaP2XhCPLs/HmcWjtYGsQY9kyLL8YRoum6vTQynLgrG
 MYVTHLNSBAasH677GsYg3i77qealkQfE/QqJqoNqG3iLY7O/KZHPZY5YrU8+Hp8rVsVgtiirMC3
 TxSMcq/YtQM6Sr2MR
X-Received: by 2002:a05:690e:1916:b0:656:30a1:70e2 with SMTP id
 956f58d0204a3-660dbe62b89mr2631617d50.6.1780485931702; Wed, 03 Jun 2026
 04:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260530144604.71190-1-marek.vasut+renesas@mailbox.org>
 <8e28ea5f-039e-4620-bb88-8e992290da58@mailbox.org>
 <CAC_iWjJHEXshSgbimHRo9LPOpL36B_cOKiyrsNoqMEuyFeMdxg@mail.gmail.com>
 <0ec14745-ca08-41ab-bef7-2e94545590da@mailbox.org>
In-Reply-To: <0ec14745-ca08-41ab-bef7-2e94545590da@mailbox.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 3 Jun 2026 14:24:55 +0300
X-Gm-Features: AVHnY4KkeNhgkw9iZI3QlY1zWfrUlzKLDV30Tqir8jhNWxTvEh0K7PYXrAx6CsY
Message-ID: <CAC_iWjLVvEKVVZrpUUWQ+gW3idfkuajS-2drBSS=F5ZckFSyyw@mail.gmail.com>
Subject: Re: [PATCH] [RFC] lmb: Optionally limit available memory to 4 GiB on
 limited systems
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 David Lechner <dlechner@baylibre.com>, Heiko Schocher <hs@nabladev.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Holger Brunck <holger.brunck@hitachienergy.com>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Tom Rini <trini@konsulko.com>
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

On Wed, 3 Jun 2026 at 14:12, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 6/3/26 12:37 PM, Ilias Apalodimas wrote:
>
> Hello Ilias,
>
> >>> diff --git a/lib/Kconfig b/lib/Kconfig
> >>> index 77ebc79e1db..29911068a69 100644
> >>> --- a/lib/Kconfig
> >>> +++ b/lib/Kconfig
> >>> @@ -1295,6 +1295,14 @@ config SPL_LMB_ARCH_MEM_MAP
> >>>          memory map. Enable this config in such scenarios which allow
> >>>          architectures and boards to define their own memory map.
> >>>
> >>> +config LMB_LIMIT_DMA_BELOW_4G
> >
> > This seems the right idea for now, but is it really 4G or ram_top?
> I think the LMB configuration should in fact be board (or SoC) specific,
> because RPi has problems already at 1 GiB, other hardware might have
> problems at 4 GiB, etc. But this config option is the generic "make it
> work somehow" flip switch.

yea agree on that. I was just commenting on the Kconfig name
Cheers
/Ilias
