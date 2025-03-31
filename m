Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C8B0C3600C
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 08:01:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 712EF812BC;
	Mon, 31 Mar 2025 10:01:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xRZH2E41";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6D998144A; Mon, 31 Mar 2025 10:01:49 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 963D78129B
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 10:01:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cfb6e9031so38354635e9.0
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 01:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743408107; x=1744012907;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=2NQusOpCR1CNJ9rxWb6YO6KKNn5YsCAaNp9Vg/iPMxI=;
 b=xRZH2E41yfS/bw+4PNQLjEBWh4Fd2tiqSuOujzznqmA7JBZp8oo0vOpvQN0etF6hcY
 pHwCGkNSZMXk5Z61GWgv/Zh1l9o25o7M9oW0nXSSXS+xl65SpxOwTNsEXo/iLr5UfTlE
 XIOKzZqFojhWZN5WEDz1RCYxcGod9PZFfUuxMVzANOElDJoKtI38XRMzl2jejbj7qsfl
 +W8SOSND5eytvAllG8pGfoz/s/M26uahwiSP7fJiTXfIC5gYb1CVaVbJO8Ibxrk7C/zJ
 hyAWsPRDIQ6omrNxwhINE8Nkq3c4zI45w9TsK3nMVV0Vn1BrQHxeSYrpgkkYadOQpotw
 tYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743408107; x=1744012907;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2NQusOpCR1CNJ9rxWb6YO6KKNn5YsCAaNp9Vg/iPMxI=;
 b=IYi+Y57Dh1ymH2NK4hr9dJt0KvVtbJY1WSUS11WdJQPGTQpzN8GrX5nYAFOr/CD9Av
 mMamTehBpz5/Dvgh0yTnv6fw9jByAo9LOdVBGWZARzighdMFpbipa0MKNil8Si7gLDa3
 2Fe+aV6NVOoIGEF/QPWZ5G3vieLZYZ/S+5JBlRzKlAbG3gbgKN7ekKtNgWUM0FZiZsQz
 yUc4F7lgayX+1341rlWzafvWTsKa5mrOpmQZn9p/h8UOCLtBGMoqZ23NnYC69Cj4tQmb
 uassn7Z4TELGmCBrKfaGj7bOFFpwA/D3wKkvN0SmS6V9fc72hIUzAdfG9jA2gUNVwJpm
 ajXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3GEPcMIW6Rgh+vy000mw/KEA6Wk5OTeQBs0WDCXE4d9r/s6AL3ayDa4N+TnKJkgaemhEJyaU=@lists.denx.de
X-Gm-Message-State: AOJu0YxhEsKBGa9kPVGIj3NQ1z87nLLjDBslLS9Pq5odhD6IKEY93dKW
 qDYOvjZ9Lv+WM7Suzm0ztaAtFqg7XwbDPcAQL//t5oIsw0fbV8o9p+alzd9GYuY=
X-Gm-Gg: ASbGncvaY3n/jKMpVEfpybilkfaZYf6Hu2VNreQWItG0yYMrmLddZcjRl+8+JvK8A8E
 9Ao5hSJmEjw1ZC4BJ5wzaM1ID/fBY5h/3/OxsNO6ORnoAaWTIhPdT1uOC3CtasoBQTwOZGkEEUR
 FmCJiIUzNFEOmSJAqcfKYXGNpmJ5PQ2ErjdQcXZYmy5GqhXbbCK3p99HjhMrc9KMKWzjNWQ1a/R
 /vH1AT5IcWgFzFs01roDFoSQjFlSXu2W2BSUPL3wMQ4MXVPQsyhzHIZ6ToWpthzOOZ+86meqSVD
 bXqTLLZGHQEb88v71EKvyw3jZ4L/oLmhnIWztISqmPlNjLu4px2trxQ7u0CdrvxTd9O+md/FdDb
 3oPckvybuVvzLCA4jUg==
X-Google-Smtp-Source: AGHT+IGiBpn+tUiJ68gn3y/SUkvPTOpK4Ytz9xWrh+I+CICWUUWcqzACXUMq86o9pLwL0jKPJCCC5w==
X-Received: by 2002:a05:600c:870c:b0:43d:683:8cb2 with SMTP id
 5b1f17b1804b1-43db624a3dbmr73854185e9.14.1743408107019; 
 Mon, 31 Mar 2025 01:01:47 -0700 (PDT)
Received: from localhost (lfbn-tou-1-752-68.w86-250.abo.wanadoo.fr.
 [86.250.199.68]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82e6adf6sm155434055e9.15.2025.03.31.01.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 01:01:46 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>
Cc: Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 03/18] gadget: f_thor: annotate switch/case fallthrough
In-Reply-To: <20250327153313.2105227-4-andre.przywara@arm.com>
References: <20250327153313.2105227-1-andre.przywara@arm.com>
 <20250327153313.2105227-4-andre.przywara@arm.com>
Date: Mon, 31 Mar 2025 10:01:45 +0200
Message-ID: <87jz85pr12.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Andre,

Thank you for the patch.

On jeu., mars 27, 2025 at 15:32, Andre Przywara <andre.przywara@arm.com> wrote:

> Even though we seem to catch POWEROFF and EFSCLEAR commands in the THOR
> protocol request handling, we ultimately do not seem to handle them
> (apart from sending a response), so those commands still print an error
> message.
>
> Annotate the switch/case fallthrough in this case, to make this clear to
> the compiler.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/usb/gadget/f_thor.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/usb/gadget/f_thor.c b/drivers/usb/gadget/f_thor.c
> index 54372118348..540b9f88237 100644
> --- a/drivers/usb/gadget/f_thor.c
> +++ b/drivers/usb/gadget/f_thor.c
> @@ -138,6 +138,7 @@ static int process_rqt_cmd(struct udevice *udc, const struct rqt_box *rqt)
>  	case RQT_CMD_POWEROFF:
>  	case RQT_CMD_EFSCLEAR:
>  		send_rsp(udc, rsp);
> +		fallthrough;
>  	default:
>  		printf("Command not supported -> cmd: %d\n", rqt->rqt_data);
>  		return -EINVAL;
> -- 
> 2.25.1
