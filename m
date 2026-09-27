Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF85C9830E
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 10:41:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 474114080C;
	Sun, 27 Sep 2026 10:41:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id brOn2XnczjXi; Sun, 27 Sep 2026 10:41:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 94034407EC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790505709;
	b=tF+NSfT+zJ+vGuWWZ7P6TkY7GGTMxJ5szDQABz7ojxlOuSvqcNoiKLWKiCU5FTXDU7lA
	 cnaFilaGa1BwTj2gw+bjf94FSnDKGCacGSaiKBynV9KlktIjWyHtIKV25vRZY7VQh6wKU
	 wRUoPkiW2sIhOLb3omESWH6l+7GhQ04FaC+kPzlVCXSKH5o+udCcVYvilbF+AJyzWdz9j
	 PiMWvH2CUnQBBKMGX/fsVzEYGyWxN0JqE9XQk1FAMBB+6Ptzu78YKd7o8SLY928DIICQp
	 b95UBTohMFaDspuYKSL6LOrbcwpfZ4YLnK3nqkZdriMQ3S6hSg0sKejRVZ726K9JhmQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790505709;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yUp4cvIR55ZSbHdANkBD4WuKt8TnJXDqvBIQrJGLzRQ=;
	b=cT7lB2t4/laVZ+WetQBrgwstXxeh4+8I19izl0/zLE2yS0HMF/BrdAbiQreCMX0yBbJk
	 i8B468txg1cVT9ungsoqn5We6RzYkRD7EpDWYqpgsii4CrMb0Ym6bzUz+ludLy5gIRnxY
	 0iRSs4r9A/sSr/qYLmiI5v3SmaumXiGWF/ZYCnTwK/g6EdRhIg7+Q65KCa2OQRIApRQUq
	 QuhOv4ojcnLQ3bRghyfm9g8FfVyh4d4MYT4Cb03x2L+96szuggBlOyECjeOC1x/UlAqF6
	 3dAWD1Q7LezByjo5cZ8q/DyxfJZJw/Okp0QiJSZvKPlxQn/Sa9JiodObIjXSf8osX8Q==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790505709;
	bh=yUp4cvIR55ZSbHdANkBD4WuKt8TnJXDqvBIQrJGLzRQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MrFYW3PpZrGEKv1bJnbfSRDUsUjlnSZZijQv6lOX2HO98SMcQrr5MsBbMhLE1lZ3w
	 x5VGFKJCQH2ysvqbhWH5foFqjqPyiJCWLpNhZpNHddTPyQaqxVo3udFv6z7C20CWAk
	 clVEacNXxFoP0/XTdXLoryNlWP0KK6SgmEDAqEMGRQ3KV4KEcugjhgna7ryKM0OrSJ
	 wl++mOCINukNmlwM8Vr57injdkUGIR/1pr2zQst6wmb1P9uK1eQi8LaSVBm0o6WMC7
	 jdMoEqQWT28DNBH4fsqpk6rhVgalbc+ISSrNNlpqMubnIZPmrG2I7InEmgxTViIphL
	 O8xBYgW8MdtSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 94034407EC;
	Sun, 27 Sep 2026 10:41:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0BBC0334
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 10:41:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E5567810BC
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 10:41:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z4LaJagci_0J for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 10:41:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EC29B810B9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:36::11"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790505706;
 b=H3mGmqMcmhXeXkrprpWYOCVXq7erfNd6w2hzPitfxUahlJXijBsGBHo/6JqZt4zkBpln
 G/HOCXyw2F49qpciEYt3Qylnv7j6LC4e50NomxbJ0C3yGh+1XNauWZlO+VGFwRMQwuG6q
 0J/40KoXF/Ri4TxLhjZ/06zu2mjQHSctSo/FM6hPzkrMalOP5xLwBcZnhL/XVsDZEfYch
 WpSM0yQR7eg0f34ALMeYuyieObWljfghZeddss2Cbi378iJ1pqs2pN/ctcGDbZDdso0jL
 I1ERa4z1WAnQt3uc7aBiic3XkCdxW99FsUd4usfnNgSmi+lq/kGwJrgU3xdG3oH8TXw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790505706;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=yUp4cvIR55ZSbHdANkBD4WuKt8TnJXDqvBIQrJGLzRQ=;
 b=HN6FMw6ADAifWppomZGZ8duVEjEzWV0eWnTyD7bd0VGIiod7WAwccncPQB5DnmvQ+aJ8
 8VWdHTwrh6WMIo4xEk4gmoB7hC4ke8WMppph1UzJ4u1/DZ1252KuhXz0Zz7QlFt0i/mbc
 xQt6U06Xf6DWK082QYbzeHXOzVtf9Zu8m42TJz8rE8l4siukcyZBJISRIGvhEmpb+LLIW
 NujSd8/ALppBEgdQA1n4kdFjclHLlu6fiOr/wIb8Wqut3xRDUZrqM189tMRZH/WKfOv3H
 0SEYZBTmR3wVT+0i/BJ6ANJgVEyoVxDSeBRK7+bCGwFeZboQFFSLi4XFnxd0psXBHQA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="hkMZ/aeE"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:36::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:36::11; helo=mail-lf2-x11.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=hkMZ/aeE
Received: from mail-lf2-x11.google.com (mail-lf2-x11.google.com
 [IPv6:2a00:1450:4864:36::11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EC29B810B9
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 10:41:45 +0000 (UTC)
Received: by mail-lf2-x11.google.com with SMTP id
 2adb3069b0e04-5b8ed020ec6so1152414e87.0
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 03:41:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790505703; cv=none;
 d=google.com; s=arc-20260327;
 b=LqSi3Dm7XpjGlFlE4kN3FYTg3VjNNWf4U+D32CJWRet8vIocdMn/HEmD/LD6Kb5Joa
 vqAY4tPNYjbzVPKsjUkWIMyZ7F00E9KDOoK3KCqJkVTqTsgM3qv4vLPcbQlTWOFuh4op
 Ylg4IJcP/OZkgz2BG6YLFLd8vws7C875koGrkw9HdCnbtYxr8m5w5TEtlJvUJ7M1FKTH
 hmNTjKbnxPiTxH+8t/7L0ndHyoAulfcDNgNoTYbKoEAfu4j00jldYbc0sZNJWkKAPrUy
 UZ7njt0lzMmVFlcNHrsju6KwzI2LbtI0qW4fMmdXuOb7A7KyceORNqCKkkNzwlGIDumR
 O/zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yUp4cvIR55ZSbHdANkBD4WuKt8TnJXDqvBIQrJGLzRQ=;
 fh=QwJHIE5fulogluZTKR1R6q869bB38CimCRPyRfuZ5nc=;
 b=h/Cd/ZYtbhHa1zCOejS3VoZVAMDr49SDUdsTuUkMc01xLsgv6IljIMhIwdsjMMlUK6
 U0AsVov/IsxV0+mFWXCGpblA8PPZMOooNAqlkD4g9eZj103JH0rGti//E8B5Mrlksekf
 lT/99Wk5Cf3s5+9AsD8bTgQ7ii953I8ok0iL+xJt4L2HLyZPUXCyVXii4rQ2J6BtX/aR
 imxaDjsQN4IdND1C47LKeBGtE+gaD3ZT33b4j+yA42tZwAl56j9OiCnIoxbt94ywGUNC
 zUGUuap6fBHeIXEmIV2wR/rQVbBtk0HsGm4URPxocJa+MABo545aUcqDjKvpdEIu/jjI
 jvOg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790505703; x=1791110503;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yUp4cvIR55ZSbHdANkBD4WuKt8TnJXDqvBIQrJGLzRQ=;
 b=hkMZ/aeEpzjpGdJfi//SPoWFc50Fhkh5zgMHkMlnFzXbv2DCWW9o/LmSwmVbavw1eV
 9DZvAJgcL+awW4ZSTs+7mHjfuOXq+W76YbmkYiMyGCGM/vkOa9tA31W+YHAYs+vYzQsB
 P+wg/RGoSqBfQFM6YDQSBJ7yYuGF0c5tFn1f4DO/a9SPJqwwRrKkRw0G2/FcdKeL+fmp
 X5VZ/7U7Hw5NXkQY++8zEHWOhwspVSEZJ6iePwtGMzufFoaAxwNNs+oywMGzA2LWzG4R
 MOCN25FzPgVJaO2q+qM9FN6WEEyjQKyIffNtf0AEvCtkWUgrP7m3GK3UIJscU4iqspNX
 B8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790505703; x=1791110503;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yUp4cvIR55ZSbHdANkBD4WuKt8TnJXDqvBIQrJGLzRQ=;
 b=LIeBLUCmhT/KMO3rfAx0RIC8j2lIGlGxJKf2HKfQ5nGbSglyJ7OeoHeRB/aSyxMjcR
 vmqO6YNqehPjCAW6RGM53xgGH7KxkvPhPD0mfs5zP52+YACqMeigzr0XVgDQr+ms3/oA
 Qkevhs58LGt5r3B9Ua3S6UZJR1wGTuiM+LrkuD1++Se7+DGUO+GJPsWTkX9WmP1c5NIA
 SJRKvd/nrtSvg5ruyxdCL9rxLAV415f1Kv2IXMOBYAy7G1x1/3zQ9Y0usaClGJ8/1XXR
 ybpxOWe/Qs8uVJPc63oBKP+iPYr3dLtQKm6ik+1dujR6m4XHZR7i+lTMoOMh/twS2qnt
 c+1A==
X-Gm-Message-State: AFq9FYIW5HEfXNL0oigMQe0WNO2q+F1w29c/7BGe7J0vpkr4PYqTXCtR
 sgKXPuaa2e8PBCUtfrHVUFEoXuhPiRU5WzfvasrdsQJ1YEivrhwkzpgLoDXHcbR/iLByqxs8fJZ
 m6uLxLQaStvqC91/CSB1Z3A5c/NX5tt0=
X-Gm-Gg: AYBFou3hQlWlM1QIXFGbrsahOXG966LHTLzhT4NV5zSTf6stON5FXCEmAZsX5HeR2FD
 HT+eMyoRB8LxICrWbC/D1GJ/K8d7pO3rifWtOIb1phwaL5yTEJTXg6POky16SFhbhpoHvpy5RvH
 1YbSm9a768rYY9C0df+1LKwSc0hZc6cuVZEun4zkz57WQOwqKRHHrXT+lW1akaj/RH30tMxagMR
 h/ChuXO5U66AkjpTbj3qbWkXi2NflVjRDGum6hM6x4dOByNBlSQHAMEuZYFVpmowWgWeTHCkubV
 UMLfGYDcSYrIiwtbrFmLCJLDhRT+os1jh7tZIw5nJ/6RxDvd3o3Oo/n1qCtEbWxUBexPeMQwzuf
 EioOFMmM+VdUXDCA5jQnv5B4STL9Me0VI83YZbqH62jrKn4pCtyIfS70=
X-Received: by 2002:ac2:51c9:0:b0:5b8:f8f9:e080 with SMTP id
 2adb3069b0e04-5b8f8f9e31fmr33122e87.26.1790505703247; Sun, 27 Sep 2026
 03:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260922052700.528451-1-hs@nabladev.com>
 <CAOMZO5A25F+JPPPYgCSUOV27=auCbrsdHqCJ+6PVvzV9SPx-pw@mail.gmail.com>
 <3286955f-614f-5238-b1c3-1c5807dc21e5@nabladev.com>
In-Reply-To: <3286955f-614f-5238-b1c3-1c5807dc21e5@nabladev.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 27 Sep 2026 07:41:31 -0300
X-Gm-Features: AclHuK_j2MLp1lxEVx_yWRjlz3t5ZzqoBGJTxXQmB4MyTSBSVbcUnYwnpPWh7Z4
Message-ID: <CAOMZO5C0oaKnmOpnZF-NwMV=HyZUvdYTMbxqKZyYdAp9xVYAnw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] imx: deal with the RNG self test of the i.MX6 boot
 ROM
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Gaurav Jain <gaurav.jain@nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>, Peng Fan <peng.fan@nxp.com>,
 Stefan Bigler <stefan.bigler@securiton.ch>, Tom Rini <trini@konsulko.com>, 
 Utkarsh Gupta <utkarsh.gupta@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Simone CIANNI <simone.cianni@bticino.it>, 
 Raffaele RECALCATI <raffaele.recalcati@bticino.it>
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

Hi Heiko,

On Sun, Sep 27, 2026 at 6:01=E2=80=AFAM Heiko Schocher <hs@nabladev.com> wr=
ote:

> Ouch, I missed the gitlab Email... sorry!

No problem.

> Okay, SPL gets to big for board imx6dl_mamoj
>
> What can we do? Simply disable the new Kconfig option for this board?

Does enabling LTO help for this board?

Regards,

Fabio Estevam
