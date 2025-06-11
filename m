Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5881C677C4
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 14:58:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FE1582B20;
	Wed, 11 Jun 2025 16:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D90FF82B70; Wed, 11 Jun 2025 16:31:10 +0200 (CEST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com
 [209.85.167.48])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7BB882B0F
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 16:31:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wens213@gmail.com
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-5532a30ac41so6861615e87.0
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 07:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749652266; x=1750257066;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ptd1zsENhoFep/V8Vt8D9b29n7Cx04RXB1UAfv5C+uQ=;
 b=Uu+IHMy50TDOMDyVhQ794Yskdi6JfT5odf36clIVGRMo7U8GtyLx5h1hZOdNMijigI
 jq/LGFi4newblCPwN59GW6LhrPYJJUL6e2Kq40n5vM9i1EXFzNn+DIKj0t2T3gjzQhuP
 Rk9j1rYunDCZBcKruhDFo1qj/NCYMLSPdAYhblW/+N0gO5gBjMjrtch/H+Zjc6wdFVxs
 yieE8vWzrvCwAi4lYKLtzL5WdcNRDPSDYXnPB8VuZrTp3H1Dmy62AmQ7OOfnRSjNApUT
 PcQcwl+ZdbvTDI32uH8xGcZvf/FPxX2GM46Ai8+iXaqbvg+PsZHhKhfx67C8Ssez+QkS
 dtPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+wEid0Kcf/RX/KTA/an0gmJncQrQW+x0Xe4jKVMQnJ2zj8EAgLzHccjpNabZWwvw10mSuuLE=@lists.denx.de
X-Gm-Message-State: AOJu0Yxs8IZJULZDpn+arGiE1fN95Vtc9mlFkcZlEQoTPfGZtKjoXbnZ
 gNpPPSDaiFV47//k8rVygFfPts49JsQxeoHhvrDnwWyTLJaqWnaHxIwxifFsgK34
X-Gm-Gg: ASbGncuzwldP4hAgCPsZ37jLat5Vhbtg1fUkOjduqnNm9x0BNy7EMN3G7XmfGmY/3FZ
 0IBWhB+XksDNlMgYTl2wNUOp92khkmybGBKULbrOHU6d3CvNl1KOGtJba/j1yq4F/epFwm7VwDV
 6+jwOTKXhLSUiDg00BvnLJBWemZaNVmC5S0/agVHUmgpNUcgIg1WfV0KFNpGQXLSY7uIHtwI/7a
 /nm5LIobaLexkIqZQLtaj/xwp3OW5odrL/Y+4kRpbHJtTM2Ls9ZR4FqWKOIWqSb1mbZmc0cmXVP
 DA9G322JY113dDRgqsOBjDz+o1sHM7j7zEi+lW2Ns/lUlqQwxX7gTUT30SVtbUzacAGtY7PlcA9
 Tx4fhGnw9Sv3bZ+w=
X-Google-Smtp-Source: AGHT+IFkCAw6JXDiUFo/XX5bVU6hAcBlPEZI1trJ/ZF0oe6+D7Kt+y8Qi9fsRn1Hv1fGcZ5i3bJITA==
X-Received: by 2002:a05:6512:b1f:b0:553:2421:f5ee with SMTP id
 2adb3069b0e04-5539c227676mr1091836e87.29.1749652266146; 
 Wed, 11 Jun 2025 07:31:06 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com.
 [209.85.167.54]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55367733156sm1962423e87.243.2025.06.11.07.31.06
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 07:31:06 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-5532a30ac41so6861535e87.0
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 07:31:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUaCy+EMvTzA4uc0IzpjdAN/NRyQqD10L0FYkWBXQTflON/bK5q65Qx8wHNou2ZJn+wxZdKoSs=@lists.denx.de
X-Received: by 2002:a05:651c:4ca:b0:32a:6c09:2d7a with SMTP id
 38308e7fff4ca-32b21dddaa0mr11752111fa.30.1749652265835; Wed, 11 Jun 2025
 07:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250610190820.1462097-1-christianshewitt@gmail.com>
In-Reply-To: <20250610190820.1462097-1-christianshewitt@gmail.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 11 Jun 2025 22:30:52 +0800
X-Gmail-Original-Message-ID: <CAGb2v64-=p8LCBXT+4axfFWQ+s-5M2HjzMMHYgQNN64CNFqzug@mail.gmail.com>
X-Gm-Features: AX0GCFtm17odO48T8kJAswQd1BkXOZb0SaShi5T30hrtEXSR-Tt1TIgIjc95BAQ
Message-ID: <CAGb2v64-=p8LCBXT+4axfFWQ+s-5M2HjzMMHYgQNN64CNFqzug@mail.gmail.com>
Subject: Re: [PATCH 0/2] arm64: dts: rockchip: roc-3328-cc use 1600 ddr4
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: Loic Devulder <ldevulder@suse.com>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>, Da Xue <da@libre.computer>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 11 Jun 2025 16:58:46 +0200
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
Reply-To: wens@csie.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Wed, Jun 11, 2025 at 3:08=E2=80=AFAM Christian Hewitt
<christianshewitt@gmail.com> wrote:
>
> From: Christian Hewitt <christianshewitt@gmail.com>
>
> This series adds the DDR4 1600 sdram timings for RK3328
> and then configures the ROC-3328-CC board to use them
> to give a healthy performance boost.
>
> The patches from LibreComputer sources have been tested
> with v1.0 and v1.3 boards [0] with positive results.
>
> [0] https://github.com/LibreELEC/LibreELEC.tv/pull/9590#issuecomment-2571=
670366
>
> Da Xue (2):
>   ram: rk3328: add ddr4-1600 sdram timing
>   arm64: dts: rockchip: roc-3328-cc: use 1600 ddr4 timing

Tested-by: Chen-Yu Tsai <wens@csie.org> # boot to shell; no stressing
