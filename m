Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E00C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 13:44:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 656CF88261;
	Wed,  5 Jun 2024 15:44:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HhB+hSau";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7A8D882E8; Wed,  5 Jun 2024 15:44:14 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C6BD87AD2
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 15:44:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2c283f0da84so504814a91.3
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 06:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717595050; x=1718199850; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KlTjhwM0Vy8zLCA+/t83oGn5Zm+6cq15NFl49rhOr/A=;
 b=HhB+hSauQtOiuLk3OjY8NfxMUMO5nYi5JKJxOPEpgEovorQuvRXhHOybqpmSb6b8OB
 pwmoH20E+bMA5Ycv8fk4v9UYS0XfXcXBWBKevFUdnMhdPx2rMkpjsg8nrPAiYjytaDd6
 hD7i07/hJuRdazv0imOZZmhoXcHm9gL69i6vqbMsD1JIDVCDVU2cUEQKfMAEZYb4omJE
 unJF300PzxHctcjO8DglObYdoSJuazVL9LpgHP6dx/Et+AIqsQxPEbOmqTUvL6dnEsXz
 2rsJ0VSXIFYQX0LbmmzPuTR4XwQ+dIVY7mhuLjXuc2xdplJl4JD7WYcIsHjSF0UZ2uDv
 AdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717595050; x=1718199850;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KlTjhwM0Vy8zLCA+/t83oGn5Zm+6cq15NFl49rhOr/A=;
 b=M1/cvnoBY9N0z1vtdSJh3/QN9xnkVoVZMRYkGLHmqW1xUZ7Y48MFlXUGaTd50ezVvA
 8j/5Jv7akPYMYRenFOSpk0pD84ROPaBYoQ3ocKnJESIIu6bBXvbH8tCDdmPKeKloUFzF
 hEjxb/is6sYcPdFSmlVW2lPvturBaGe40yWP/Iv/aG1A3lCWCmW81BQczSChlyucARXy
 0ObTtqGISDJUd/6/vIR78o1W/L3xJs8YSe4iXljN0aJrk55AceD7FNePC6oGaFy/0PKa
 xBpvEF8pq5/vgm0feb4Gz0Y1cPs/eG0IacS4MAdsbm3bK7tvwp1P7h8CLzHVDq/pCdhW
 4ryw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/AerojZgUv4kZMNbQq7tiXfDlio3jDayFtCK+LoUfnJptq405mcm60L7EgZbGRMdAZ3j+sMVpD2hfzSXX/mbNfh84QQ==
X-Gm-Message-State: AOJu0YzAQOUZ30zUO60jtibPmIvT2/MV0aKQ2pEhy8VxltoR1gfchTI1
 r/UVliNhuyy6wdPBbu+jU91kfswBdZ1RmU7yzWRw7G4myXo7JM13mIJ69p/Z61EAgdK7bwirsmz
 ax6qpo8cCX4gAIvUDrUtgkgOp0jFEGfWK2w5PDA==
X-Google-Smtp-Source: AGHT+IFTpHJIMF+IL7tLOg8cvHI04MCtSx2LP7SKK3GdsDBZuBRaXQeGsGPxzfjBXewvDCIEQlWDABM1KC/VjEb95sc=
X-Received: by 2002:a17:90b:60c:b0:2c1:948b:6f2e with SMTP id
 98e67ed59e1d1-2c27dd555bfmr2426671a91.44.1717595050267; Wed, 05 Jun 2024
 06:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org>
 <20240531-b4-dynamic-uuid-v3-6-ca4a4865db00@linaro.org>
 <eb3681f0-ecb9-4775-9093-5640aa408f50@gmx.de>
 <CAC_iWj+s67woD-USmT3+hDq7yO9K_G=WS1DG-oJMM1byPb3JNQ@mail.gmail.com>
 <8e4f962b-77c5-4eb7-8147-cd00a73b4172@linaro.org>
In-Reply-To: <8e4f962b-77c5-4eb7-8147-cd00a73b4172@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 5 Jun 2024 16:43:33 +0300
Message-ID: <CAC_iWj+Uc7HzhCNueLMUfGKdmmLVhsR8oJKSh+0f6ANJqpFpvw@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] tools: add genguid tool
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
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

+ CC Sughosh

On Wed, 5 Jun 2024 at 15:29, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 05/06/2024 11:25, Ilias Apalodimas wrote:
> > Hi Heinrich
> >
> > On Wed, 5 Jun 2024 at 09:36, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>
> >> On 5/31/24 15:50, Caleb Connolly wrote:
> >>> Add a tool that can generate GUIDs that match those generated internally
> >>> by U-Boot for capsule update fw_images.
> >>>
> >>> Dynamic UUIDs in U-Boot work by taking a namespace UUID and hashing it
> >>> with the board model, compatible, and fw_image name.
> >>>
> >>> This tool accepts the same inputs and will produce the same GUID as
> >>> U-Boot would at runtime.
> >>
> >> This functionality should be integrated into the mkeficapsule.
> >>
> >> Just pass the device-tree into mkeficapsule and generate the GUIDs
> >> whereever they are needed.
> >
> > I like the idea of moving this mkeficapsule which is already part of
> > distro packages but,  isn't it easier to pass the compatible string
> > node and the namespace?
>
> Yeah, we only need the first entry in the compatible property, so
> parsing the whole DT is a bit overkill.
>
> I can look at combining these tools, can mkeficapsule generate a capsule
> for multiple images?

Not yet. There's [0] which adds that functionality but we are
discussing parsing a .yaml file instead of a custom format

>
> Would we want it to work such that you provide the namespace GUID,
> compatible, and image names, and have it generate a capsule with the
> right image GUIDs?
>
> Or would it be simple enough to just incorporate the functionality of
> genguid?
>

I'd argue for both since people might choose other tools to generate a capsule.
So you want 2 flags ideally (random flags)
-x: dump the autogenerated GUIDs
-y use the autogenerated GUIDs on capsule generation

Since mkeficapsule can't generate a capsule with multiple payloads
yet, you will be limited to just one, but I guess it's easy to expand
it once [0] is merged


[0] https://lore.kernel.org/u-boot/20240419065542.1160527-1-sughosh.ganu@linaro.org/

Thanks
/Ilias
