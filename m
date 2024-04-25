Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E41DC10F15
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 16:23:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F49889077;
	Thu, 25 Apr 2024 18:23:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m3rvD4Mi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04FEB89038; Thu, 25 Apr 2024 18:13:38 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C008D8903D
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 18:13:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hughsient@gmail.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6a0426d72ceso562356d6.3
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 09:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714061614; x=1714666414; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U2PQX4SkDf/EzV28YNsTNC5RWWz59W783pHKrVePLfQ=;
 b=m3rvD4Mia6GZ4xXbZNd3rW9QwWU7EIi42DLhjndlMpIG8pHiQqFHpoRDvrpyBXbttm
 yAKVj+rDhlj/f7RGnH+jiOQnWE9Vl0hgeJT4BlcDNftqt6oQ1pmCBjuvsVwtmbfVqwZr
 3kTk/BFYODLJgHJSDZOCY6/rmTo+M34NO8mPQFmEU/MO/lzEsi4cXhVh92K5/jeF7nCj
 j7DR4QHG2aek2yGdORYF4R0cykAGc6sCHVyzBJbqsPv5eaBNnav88C5LKQYKJA5cC3+V
 GWMxv6CYtKm6qGkaWHd7NW0aGJpzQ36Z4V15nPs0bxGtRLT6hIdBBAGgUHZTQH/YZHTL
 ZiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714061614; x=1714666414;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U2PQX4SkDf/EzV28YNsTNC5RWWz59W783pHKrVePLfQ=;
 b=oMtRRAbpLW+CPDeWWmgAo7/xNnxiAwNJete7dIGemSN1dmMnYbNnUyZCrG75hHlQQC
 8azK5kUbuRQ36jA8xm8JFYkVCi3cyUtHIxNNSpDb6sy8q9z04fDnrzrz8RhhQ4r0eMuB
 etZJYxrVcTMLVk4o4eL8d7EtFNEM8HKSoxYShhbhzWCbOybm1Cl2rQcJyiWgyhnQQ0jM
 lKEiPpQr+hZ8wXlgkDZ1VtIwehv49YjJLYPWKA2GoDE1+/kViN4csJpDntzEACCNDbE5
 rrekM5mj7sWa/d6gxA/X7YQmP6tAa7Xo0M5L6W3AaP7WKmbWqkPEPdL6p3BoBEDHlwPq
 8Jww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKkkDAq3US9StEHEBxwPtJnrgUnIW8q0e4+WYn0FXXwstQZxnpMOKXQuHAtnq32Tcmu6prXnBcXBCv4DrS++GYSNkqtQ==
X-Gm-Message-State: AOJu0Yz64AXFQWWe4GX6j0nW4bsEEBwgklZ2cgH3fzTcjBrglgVKIGwx
 jrAp1LjwRSfHu9CKvyFZeD9ynBjad3HeZIv5drh1Oi5Tiiw2x7I7iH2WqBnflkrAjg4ottirbjj
 WlvWL0h97WYtEG85thL36uUyfW34=
X-Google-Smtp-Source: AGHT+IEE2nxUGaw91/m4nNn5traNusLve8+k8ZVX8nHTnpyYcNJPocB8r8U0fIag9Z195L9s0nBds8IpQ2d8LTw/zNk=
X-Received: by 2002:a05:6214:27c9:b0:6a0:a98a:481d with SMTP id
 ge9-20020a05621427c900b006a0a98a481dmr16775qvb.2.1714061614494; Thu, 25 Apr
 2024 09:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAC_iWjJNHa4gMF897MqYZNdbgjFG8K4kwGsTXWuy72WkYLizrw@mail.gmail.com>
 <CAD2FfiGuFaC=r+TGfq9auzWJbyzVNbug8zR9RzSwM2+Uk52d+Q@mail.gmail.com>
 <CAC_iWj+BonsVbA5Bw3Kck2k4b8SXru0U_Y2kAmx5=_t6SozotA@mail.gmail.com>
 <cd5ca19b-befe-47cf-9a84-f610ae7f04c9@linaro.org>
In-Reply-To: <cd5ca19b-befe-47cf-9a84-f610ae7f04c9@linaro.org>
From: Richard Hughes <hughsient@gmail.com>
Date: Thu, 25 Apr 2024 17:13:21 +0100
Message-ID: <CAD2FfiELXfvc9jEDpKVx44BnK5yDpVViARkB0QrHkpMRrdsVEA@mail.gmail.com>
Subject: Re: Capsule GUIDs and LVFS
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman <jonas@kwiboo.se>, 
 FUKAUMI Naoki <naoki@radxa.com>, chris.obbard@collabora.com, 
 Paul Liu <paul.liu@linaro.org>, Heiko Thiery <heiko.thiery@gmail.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Michael Walle <michael@walle.cc>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, 
 Michal Simek <michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 25 Apr 2024 18:23:08 +0200
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

On Thu, 25 Apr 2024 at 16:16, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> I discussed an idea with Ilias to generate GUIDs dynamically based on
> the board compatible/model, which seem to essentially just an
> abstraction on this..

Yup, that works too -- on the assumption the compatible string is unique enough.

> >> Of course, it's much better if they have different GUIDs
> >> in the ESRT to completely avoid the chance of the wrong firmware being
> >> flashed on the wrong device.
>
> So expanding on the above a bit, the idea Ilias and I brainstormed was
> to use v5 GUIDs (which are deterministic based on a "salt" GUID and some
> arbitrary data which is hashed together). We would use the board model
> and compatible, as well as the firmware image name to generate these.

So that's kinda like Microsoft CHID, and I'm wondering why you
couldn't just use one of the GUIDs from `sudo fwupdtool hwids`
actually *as* the capsule GUID.

Richard.
