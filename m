Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3AB5EC1117
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 17:53:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CB4883DEB;
	Mon, 23 Feb 2026 18:53:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UzK3wVY4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F05EB83E88; Mon, 23 Feb 2026 18:53:08 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0803283E83
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 18:53:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2ab39b111b9so19767225ad.1
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 09:53:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771869181; cv=none;
 d=google.com; s=arc-20240605;
 b=krzl7n4bZNhmWMqXskLKpoBM38rhlNeFcuXADMfjcYWKRDBxxrs8Ij0ULzx/uiqDGF
 kyj6ZoKy8wMUTdbircIVF2LD/DeCRfGuwdljQNqwHtK/+qaNe0khwHUMy+H0cPYBMhwY
 lb1AUPnMnHHkO2xkyg2f9RiCyzImbUuxSZUGUU6BdjZm8mnyRTHmx+xD3uMMyrhiKTSr
 kqnqLIqAiO11wImRTUXZzY8zrQ7ApIQRcJKwBSPzcCQ7/tKXdSU+QLJvb+V47fKArjQS
 xL4ePk1598mr58tgTtsaHhZJZNVzFm0OH33Bwj6dbphIj/bvbOV1oeedI637UJK2qSlU
 f+pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=R2mvpNafVFWnvgP8anNWoQYNbl/W3/N2zG7p+mNF2QU=;
 fh=QTwGIgOMqWN0o9uoGYv1xWu7jsOqVr7V/UIVJFnMKuo=;
 b=C1FU4WhFPLDJgZeaviQkIf6ADVS6pOI9h7rTUSmotvev03EIbVYZ08PRUWfDbN4R3i
 jvkfTk5RzN/i1vlLaj0C6w6GqogucoAzvDhj0XC6ouAl92wDthpg+qxfNYS09vMVHzAS
 HjpdqhfQG9waa+lGldNnSnBSLE/oHIreN7W++EwDoAc9dSrQsI+VMcYAWCFZSs4uROPI
 rKhSHvm/HeTJrjK0gcLsgikc2Clp1/ovcm0myjgBrZ8xP10TWD0CVV21bbr6PQI7dyya
 GN5TJWQ2rZcuUz4z9UnPNuBZ8g/ngxN8nG6EpkrduUdik+Eqb04C0jrQK0rUFXEBVtxa
 jBrQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771869181; x=1772473981; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R2mvpNafVFWnvgP8anNWoQYNbl/W3/N2zG7p+mNF2QU=;
 b=UzK3wVY4ravPF6nkH0M8wil2JDIvJsiRozuR8Fs1e5tHsvplxjQpR4Dodc/GjG0BuT
 pMt+xUhS9ucP2JrPVhm+pthS2aDm5VZ++KGl1gQcMfPJo7sMVsNHdDMeFzByXHxNjBVq
 kZtmAgqV1RQ1oCmt6Y0Va5ql6faMeGlLqqciA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771869181; x=1772473981;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R2mvpNafVFWnvgP8anNWoQYNbl/W3/N2zG7p+mNF2QU=;
 b=IN5zNdOz+p3EIzQtaUyBm1fNfgamPwOnt1abhbpMyC8xxXHgUJNNLzYLb3roVXCNQn
 KVlB++qBZyH6D/ov+sTG7qmV7Kjqy5tChwmE3xb8Jy3eFaXdcRYWSIYYhNxtX+9HHufw
 LA0af3zhcCgNDRAhLU03k/KA3ycGghPL06lX6ic66BgqRaCmhW3swO4AkyWZVtESf7Lg
 WOATzyQ/xpnSx9WtIXtkU2fq5nq4CKtvgqmDaB6kxjF6NRdnwXW9T91lJalX/K2be84T
 OEitCoxpaMo+/znoy/WZ98FF/8zRebOIOmFr8xvuvuo/+pQrdPeU9uS8bEZuhC0upud1
 WtxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdKkkUKaFXsRwZv5eq1xv5M2rBKAQUaezzKuwR6AIZ7KzMBxM/mFsfRhaewWi+Jzn9ZZKc/hk=@lists.denx.de
X-Gm-Message-State: AOJu0YyEWqGJpkV0SlblVJUapVtkPBQd+CDGgsrRpAJ1AaZPWc14HXhe
 oy+2AVOY3fD5CGAtzb1iv5FC/0YZjBFjnUKBeqhVXBmbVfnotRYsttYaMKLWTA8CwX/Yzs1ZI7/
 aFV/LShG8IIJ+SFAnWsZYfDi8NDTQfOEmglzSHBuitlp1qX5ef6Y=
X-Gm-Gg: ATEYQzy8ifEAbdbbWKdHC/Xf8O/0fp6nbEm7JB6ibBUoGWF7h3jMFN40DhKXYvOS8wP
 Is7EZhHaAH9P9Iy9V/yOuVkxnXAIoVRVLiss6TtU5yZrUDf9Y6LiEIV4iWV1jJg+YSo570b/S0k
 Q1t8EdZr6+YYe+fBWUG2zM+0SMGYNH2S/jlOOWWUf44kSgmNGXWy+vP+JOaP2gyxS4jBJRUTqzn
 EarJ8gSrXiM24xsCEUNXUAmAKwJwMngblBRf/ilyZFctfkKYplwmTBystmYHbpyG5mfrusFCbB0
 OcWZOw==
X-Received: by 2002:a17:902:fd4f:b0:2ad:402d:4dc6 with SMTP id
 d9443c01a7336-2ad7453d922mr61410445ad.37.1771869181503; Mon, 23 Feb 2026
 09:53:01 -0800 (PST)
MIME-Version: 1.0
References: <20260219132552.1499698-1-philippe.reynes@softathome.com>
 <20260219132552.1499698-8-philippe.reynes@softathome.com>
In-Reply-To: <20260219132552.1499698-8-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 23 Feb 2026 10:51:18 -0700
X-Gm-Features: AaiRm51VO4S677FfGQUSIUv8qiBR9BERySULASzSwomgpFwH6OdLO-Uc1gEdEEw
Message-ID: <CAFLszThcWDY9bP5LTQ9S0+8V2DE0VoBQMQONfBDQ34sZ=KRcXQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 7/9] configs: sandbox: enable the software ecdsa
 driver
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com, 
 trini@konsulko.com, u-boot@lists.denx.de
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

On Thu, 19 Feb 2026 at 06:27, Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> This commit enables the software ecdsa driver so
> ecdsa may by used to check fit signature.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
> v2:
> - initial version
>
>  configs/sandbox_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Simon Glass <simon.glass@canonical.com>

Sometimes we just use 'default y if SANDBOX' on the Kconfig
