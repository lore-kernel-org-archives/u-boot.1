Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55E2CA5FC5
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 01:31:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E500F60BA5;
	Thu,  1 Oct 2026 01:31:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F0_3l1I-L6pu; Thu,  1 Oct 2026 01:31:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3835E60B74
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790818304;
	b=Aco5b18hJxEZiLGHGI4wh5w0L3ND6H4CaYC4BMA/f9/Aj3m0JrUxlZLz6xPpwLq7RTGw
	 SoYakVGZgg6j7ly2wLB2o0conNUNequQNSHXxZsrVAZw8MrSJ5IGIyncS/9heqkcsyjsF
	 6LskF3/ZAna/3n5x5ZF0JYlkQKaYkfJuywizGH+bldD1f3v015j5kNRZydxGI1lOREWbZ
	 zIHSIAGexio31lB8RH0OSdwdIt8llEXEI/xxzrVM6FsZk4Z/sZA3W2Yd7FdjZ2I7PpWCA
	 zkuZWzzBuzSDmd1S9OfsC8cWGD0N26sUJk5PUj6OqXB/Pqk6+2LUoFW7Rfhp+tv+Z9w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790818304;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sw/98kRss+cqH4ZAGfj2pKlI8dTFPvpv+ZrQfs7TTNQ=;
	b=OqkZpgZCoIsEmnNCnvOm//IO/VrtRRyGNhkH95aAwUFovobwgb6hAh/rsv1VSSLHzTNF
	 jahiQXxraW3/WSLtGXbY0qKmpkArX+BV4E2X9UB3rTHD7KrUmkGTTM0CkxFj2I8hvFiGg
	 DMQViz7Uk/mNgpcf5DWF4mopsEJd2e8RrNCF6Dt1sw/h0750C+nmJigK54ho329LYjddw
	 paV7NzpntwHfoWOYaC5fvCWvtmuPDWJoERFFbap9E/l5BAab6zDZnBAZ4oPH1QZGlb27N
	 ArDhcu9o9Tkhj+CoshhFgE5WPucn4J1lRIfOTilba6jUT517ifGLp7lOt+LgRq2aYVQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=VTUhPa6s;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790818304;
	bh=sw/98kRss+cqH4ZAGfj2pKlI8dTFPvpv+ZrQfs7TTNQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RR9plRsgMdFEz6BudWW+sq9PVFBdn8+YmtX3tf8RZy9YDOZQ4rzDzeAiEscH5xsON
	 HzjlavVK96eL6QdHvcV9hjCM9Xu2Je/bjDCLg/xhMbMtpAs0pOYMdiLa8V2bmPGyIv
	 ZpseWqtsDqI7U/5rXOWDEHyy3wzYJaRWdbgnYN42Xo3x0GXUbuJqC+R/kgYGMzTBAg
	 e+7s9zuisHdqcThJkQOuBgDYKeVuLVboaAr2Oe5QUcTF/IWiMzh9wt1pOBaB3WB+xm
	 OF/uj1OzQgX4iN3VtPRsGGmT9MQz0wRk+VuVHF48lppmnylQx4/3ObGUY3uAU25UV+
	 XKmoCxZqPDvfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3835E60B74;
	Thu,  1 Oct 2026 01:31:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A1E2A116C
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:31:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9F56D60B74
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:31:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QYQJoBCc6Wgg for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 01:31:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E878960B63
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:39::12"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790818302;
 b=R0PeBbtU/SbDng4ofO1Ch4tewis80eDg6A+vnvKVZ7gQzEhO2iubQFL3y46HRs2kgIeK
 Nt2QYMiTYB/vhGB498Ld4IHnVlAeucnA2zOjzR00An2mwgtYg9Ti2UEsHq3kLX8EOPiNs
 kHnOqF1/uzBAsXQ1oAzQlEUD9+Dw0L8E7nxY42HC9VV+CDCX6NXjhvKSA7akPtYSM6BZq
 ndo+rA/BCuh57WOFzVdfm3GEussCjo3oDt1XssBIutCHUE1kfnYEpDQ+Roif2W0cQfeUe
 q53SzwuvF0PcIJsxy4Fu5Gp+a2l24AOpk1txJwMKzOFIHpjc9HEGxrqARmwDAUxTqLw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790818302;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=sw/98kRss+cqH4ZAGfj2pKlI8dTFPvpv+ZrQfs7TTNQ=;
 b=GpaYxUTIP9IURe+qBoiXR8A2CIg2OG8ypErpCcMk4e2nQNkLUpqkOBYliX8X48VZvr+I
 dr55bEr35i7IeMqoxioBW3/EoDXC1yLAOrB1IFLOXpQzF/5BxacrYEktmCwIia6j64ajm
 2jz+T5aCQ8n0dxp95GQOYQLc+RnvEZKqH8r0GCcL39LNsuqLgrfw7MJUqFIx9I/QADpRh
 WsGNRF4mFf97F1RWA9mhJrgTqOVXBhWoj+aF2njRT+uPCJ9S8y1O8uzTgmEB3mMQZ5ZQ0
 dxDZcfUo59OvBIP1aDyezzOZBDgK8c0JFqRmQkpiCYytT22Sh8DXW0SofjdeSBeRGjA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=VTUhPa6s; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:39::12"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::12; helo=mail-pj2-x12.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=VTUhPa6s
Received: from mail-pj2-x12.google.com (mail-pj2-x12.google.com
 [IPv6:2607:f8b0:4864:39::12])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E878960B63
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:31:41 +0000 (UTC)
Received: by mail-pj2-x12.google.com with SMTP id
 d9443c01a7336-2d747f05ffcso28377765ad.0
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 18:31:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790818301; cv=none;
 d=google.com; s=arc-20260327;
 b=c9Arxr/W0YEqV+o5/Q8AVoSzEuui8HFSCenQ41vB5Jl1fwy4QNMSdNe6kZqyhz5GlL
 YWMmickhAylqlarNdZkkUFWbrDIxP/p1O8g2aAlD3BUgrTSGVfm9zaPJ3jBf30ckF5/I
 8rjeUMySOoz7ypnSk0URFysRKSZCEF+6WFs+awnnjljGjl6F7RKapKiMAKNOe1jTFm9P
 YEjajIWWuadLfPpXO6Xqt6hh+VlSmA/JQRh5T4TNQY9QqqSuzem1+cezTyDsHzdE6qQH
 Z9LD0M0IV/79KWxDxPtveyBfMxCVkNMRonnl6RO/5d+mChvNDs9Oz1TUfi3BRTerOnNW
 aKcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sw/98kRss+cqH4ZAGfj2pKlI8dTFPvpv+ZrQfs7TTNQ=;
 fh=f5e1hBatHq9z+EW4hNnDcpr/2K/cDwMlmeIUSk8XQYw=;
 b=YHoeWT0HiMF7pQLYV/X2EuIVgFTBioVlSpMS2g6faPhKttZ4xibgg/Qt4sv0Y9pOuF
 +tOgYnS3r4q2dlOfXkFAowDdgTpL+uJoT7Z3zHqWRd7PWytcWgIVVHWiqVxsVNtU04VU
 FgQG8kfPeea3haIuOuE2o0AwRVBFdbT9GvRGhI6nfFbFG9zU2rU4peb+QhwXa0BLpPw7
 PhPcNixQkyxO/xL70ANiB/liTKkmmwFN5TsjH+np3C6zyicwLc1LUiyML/UKPzA80Qwz
 MuGyLse/FikCMazqT/nod2GihXi25mj81cMUbC6kYz2pVg6gg6AZN6OKlacUuVTb+mwO
 kGog==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790818301; x=1791423101;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sw/98kRss+cqH4ZAGfj2pKlI8dTFPvpv+ZrQfs7TTNQ=;
 b=VTUhPa6sX9pYKV1va0vjUXO1fCFEB7KM7rehcXeFxfxOqNvdZhp7NBeChB5FQ0Um+o
 9RHyBQnUg1tRDkCM+K6UNWhUiNrT05NMo2+qwSkekpTJ1thWtK14G5eWhWzojR3ik9dS
 lIQjixs8SYswuEjgEnBb9kWp9Mhib/siiKzts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790818301; x=1791423101;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sw/98kRss+cqH4ZAGfj2pKlI8dTFPvpv+ZrQfs7TTNQ=;
 b=s2CNIWKpltf/KQ2ZIP3g70NSH17FbGZ3V9v+F8bPPmVKUx3uWEs543SG+csJD6BIUj
 3lavM7Tc0AvqMJoXuG/9QY/zi+TW3Lbo7BhpUHw4d7yOwFgeZvzFcH00CEsioLDugNV4
 YTeRc2ar10yPE3cEwxMKpK/6KtsBCXat0ouMtKSVcJUVP5//fpl8yE0da6GHh+a1p5tt
 g2v+eokQEa6Tc6xTjHf4cSvyOTf6ocZippt95MdtZeGQaiQIgRlM7MqDwQ31SLUHo9ck
 bmOKhrMYYYTejbWjDm+5SBqIuByW5yO1N6ze0yVK+6RVVgO6FKfKSwEGzg1Jdui6pw6z
 H4Ew==
X-Gm-Message-State: AFq9FYJ/vLyk45ZjU2GXw/HZ9m8YlFWGUUogXecV7QecUNznUuKBz6FT
 tJAZfCHy9yPHyDjcM9oBIfGlcszBsKhuguE8V0jRZcqeomNwHrGbZILObRklo1ShycTwUpmuA1y
 21n90Gv2HGO1MrBqmNymnYyLwFUWTM9Xf0ZiYaOjM
X-Gm-Gg: AYBFou0heSOunuSNLmL8hYTIMk8EG3QVE6tm/wXOWOmkjp5cfjjO9JrVHj7eQR/P+dB
 IP75kZuithQTDPzz29kzOwg7I2MRqY+kXvvXZVyXBSNSP870s6YpMQVRRWFw3w1lBVQT71I3pop
 OlMI3RQZDYlGPwGrKTSQhy1XWdQdE/IM+AHsFRdCCmK/sj+3Il/bkqwxnw60PQErY7Wy4AiOGSW
 pvJIj0hpyPG18OkAFYB6fS2twvh8q6iRKdRPqqPvawyXPKL8rzgN+DrxbBCmhmOvtJDgXYb8nnl
 j5APYVDwVIzeSWI12tZKmRNzVl2bB9kdoomR0Zzy+zDu2u59OavZpJeF
X-Received: by 2002:a17:903:3503:b0:2d8:d4ce:9f37 with SMTP id
 d9443c01a7336-2e2e49f75aemr22660255ad.21.1790818300712; Wed, 30 Sep 2026
 18:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260922-authi-v1-0-e943530349bb@arm.com>
 <20260922-authi-v1-1-e943530349bb@arm.com>
In-Reply-To: <20260922-authi-v1-1-e943530349bb@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 02:31:23 +0100
X-Gm-Features: AclHuK-moVKzpgvQIH5Hwgn9Ngoa4BXODzVVqF2_Ab7arMJeNlyIFCZk07EgaSk
Message-ID: <CAFLszTgdX55Xyr+114j1aAGrTLk430UhChb7WadGO9BoV-3t7A@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi_loader: fix image info authentication attribute
To: vincent.stehle@arm.com
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Udit Kumar <u-kumar1@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 2026-09-22T14:58:39, Vincent Stehl=C3=A9 <vincent.stehle@arm.com> wrote:
> efi_loader: fix image info authentication attribute
>
> The GetImageInfo() function of the UEFI Firmware Management Protocol
> returns the authentication required attribute correctly in
> AttributesSetting only for the first image; fix this.
>
> Fixes: 88a2ef2720f5 ("efi_loader: Enable uefi capsule authentication")
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Sughosh Ganu <sughosh.ganu@arm.com>
>
> lib/efi_loader/efi_firmware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
