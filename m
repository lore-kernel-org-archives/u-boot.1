Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE77CA5FA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 18:12:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 37906807B5;
	Tue, 29 Sep 2026 18:12:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LtqoJLqAWOnj; Tue, 29 Sep 2026 18:12:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6B940807AD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790705553;
	b=NTrPZ9mWR7rz2IFtp+8O0iY+fdrumXF7sajwzCh74xwOuJNPVxLtD24xRMfi3uNNtCau
	 gaJr6jyWlBCcTC7Jv5mTVxOqoJSJKL/qITmNh+xoaccdkn+ufx+OLcOwV4lPWT4rWpJOD
	 QRm/LvHw1jl+L8p7QQ4nVHT2YqVLDxT4Gd8cGdKGi82cFoKH7q8JxUEuztOx6Oi5a685Q
	 h2yaS7Ph67CKH0MqFl8RpdSnMTcf6rBQz6EzTWzavfsnR3iT917fSQQmu53FaHoUYWLZY
	 U6bCIrGrHMgg7G9raW7UPN1vcObebkz/OXXOt17vQnK7BUzr9nEd1oG99AkpGfYyADw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790705553;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=pq34Mt39TFECUFPArjmn/A65QZ8KuoPmDapBVD7nS/c=;
	b=mmkbIGL4TCtIjwZ8SuUdnk+hnfKYf7tSY1XqRrWbuUTZwYNeJamCEy+J0Xf9j+toRgzU
	 vp+NPBzpxf9jt40IYvki8Z+oiomP5vdgDtnb33U4poWhAYIpp0p0a7F6RnSh/oBvtIaDm
	 RSgTJtsHN3BGyNUzm2BN/D1g+SUMEEEvCGonD6/piLqeBu7c57NN8AbZmkZoMf8Wdd8Uq
	 1bHdim1KdeL8hbdMpe/ujk7v/GxdvHntzs51Fjm5R0+1sXZuHV2imf2o7ff0mBxnRe2oz
	 8jFxuuFS/7Dg//RNP+Jtw7irbrbx3S0HYaxR2GOcabkcVH9Z3vzAgVzPVqxGY+dJBiQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790705553;
	bh=pq34Mt39TFECUFPArjmn/A65QZ8KuoPmDapBVD7nS/c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XNNjd29bRqCdrwUbkRkppP+vIUwp98GJrRVSHW3lTNWznmYChEdzeCTUD7Xi4nEpg
	 mZHCIHqnEPfXTbSCq76K5GQqPfcdcZNsRunIa9anV6HP0VoLB15eH/kLCKxEhle3oF
	 NELAZ53WtCfAYJXIQ8g/HuP322X+PC453H+9vXY2Mzjiksifk2pxv3R5qy+HQJnn5j
	 s+vhmao1UXimidzsd0TLnrmGP+aUD85WJmWz2gCuTjUb+TVLgxcQ+iHyYE+WQeID8r
	 2a8rbA/5jgp1oUOEEO6/Fu7+7hQIWbHsNV8t8W1U/mLKozJgAzMWJ/YTHCv+mJUs6e
	 /dAGN37PbUzxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B940807AD;
	Tue, 29 Sep 2026 18:12:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E155C282
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:12:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D83AD400D5
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:12:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gJMeU2LJK6YV for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 18:12:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6E19E400CC
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:38::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790705550;
 b=KhSD9w/b500OunbXOUBLnfCvqDYi6ppsDW/53o+6rNg7ffZ/XVUyLGFlABXcu8MVKUIn
 p5xkkYj3TlT23I2xDxEpw+USdqJYlts6UAtr85JLfB92+Hz0AgHol8QKRCjU6RpEX6qh3
 oyxXJcQJpe1o42OhYBjIhSWOVOQuBXP7ANcSnwVWoxebmUMtIijbi/wsjI0jyFCO1FcQD
 1FmzKiwhZDSknQqtbceSWkCMs4qKBkIGFTVWYCc7GpU42/XVcGA3U5MuAbUAvFOecERd6
 yIUzlZIhaxinD96Ry7YPfZNBhMvSVgQDxO/pwvh3aeVhefu5seLiEwxqnhDZhlHk/Rg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790705550;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=pq34Mt39TFECUFPArjmn/A65QZ8KuoPmDapBVD7nS/c=;
 b=WF+AWGgay2XQNeYJOm3iy8tXTDJEXYQtLqQjBe+dY0NM3cOfa6gkd9P5GxSLQf+jRHI9
 j7oL+uwQrGFZEZJwpPZRrwR6o/sRIK3lhMHN/fIwQ37YoirHEa/RNsNQNNo5swL3IVXJY
 lrzjUANFadsSUunyhWFP8iX5qBgrModezx9R96PzUnlX1AiCWcIFP01N8SnfFX9UVmJTt
 kQltCDufXsgEGjwgvud+08S+frUu07slYawVDo/xkTm/SRu6z9n98dcIN6GCOO/L1ESPr
 /iqwk5QLucpKQJ4GnNhNZ3qiPItG2N/CEoma8lv4Ol9V2Ih2o70oVHMYyczXmeJMdxQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=sifive.com; 
 dkim=pass header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=O9ato+Rb; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:38::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:38::10; helo=mail-lr2-x10.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=O9ato+Rb
Received: from mail-lr2-x10.google.com (mail-lr2-x10.google.com
 [IPv6:2a00:1450:4864:38::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6E19E400CC
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:12:28 +0000 (UTC)
Received: by mail-lr2-x10.google.com with SMTP id
 38308e7fff4ca-3a302c06eceso39390841fa.0
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 11:12:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790705546; cv=none;
 d=google.com; s=arc-20260327;
 b=IOPxdK9kGYWsLrM/XHGG8l4sQqe+pDfQwc8OUYPte5pe4LqfICGb/kXMKCm8WkrOo+
 GEpD2WiaAQADFKqeCnt6VjmZl5hnuzffsZGzJM6AEhTw5+ZtkCQoA9/Riyp7qNrEnd+K
 5s6gE2f3YvdKZ6Vsj1tWCghhqRaL84LdriODyWTuUw8JIkGHKAEixCEbIg5q0b3vKU/s
 S97Y917y4nBKZd8Z5R1rm6rW2yQznpJNUgrsiszGk//MiOh/lPwUvi4e4L29ZbaW0mv5
 MzZGltYC9G/HqwFSC/rEABygPthWxjESWb11aCEEKQk9ymAiDz8ViWb2AlgoEGqrmLrX
 zG9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pq34Mt39TFECUFPArjmn/A65QZ8KuoPmDapBVD7nS/c=;
 fh=kB7v+mrbjPT5qs0+vC/9gb9UoUXZKDfX4/rSWsRXtZA=;
 b=LlHc5dOwUHJQnZ0UlbNOvJuul8A7skjeMk2P+BiUJO1gRUdNP4kJs02e4TEtT8REZO
 KO1P2fpZHjBv5rLMnh7UucsjkDD8FS8rHMShBPGGb+pae7IiG4ohe33CDfgeVeXhl34P
 V9HfKBmmh/Xjgarj5Dj//4pyYCDiYZhKAQ/XDIjlbVTTlykeE5pTmsuB73AaXKLUF2jD
 2QbTFewM4Wg4CztRtQ6/ELiYk3lg2vijfHArzx7vf46QIgR7a3nJP38yHZ4N7UGF7NwV
 DIulmGUyUOCZz7/p2FZALYbIXA4QCJZ+hKtfhLWQNGAELQZqmxfqwNJYpKat5oxb+/Em
 ai5w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1790705546; x=1791310346;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pq34Mt39TFECUFPArjmn/A65QZ8KuoPmDapBVD7nS/c=;
 b=O9ato+RbNSmetFM97AXwa2ri0s8z0GelPg2j0aR+ua8vcZTFXx0wi93D4xOuHtgm+n
 YkWRg7F6565GQj/NYd+a09y4JdWCkdrQowKqdGuyKds9YredTC2DwE6D1elaX/jCsk/N
 NL/0KvSAl7nha0O+8jWxzTikQ4BpbNIpRWV+fgntxoZt1pkDwGaJio5iYyw7yjvtLfAy
 xLm8Ho+KmqDzrIIVa9BYmR6qM9PspNnvuTe6daRWBflTnFTiH4IUG1+O67538rKkMJu1
 sZyqSdYVa3doJnaUKnDEoGIEpNdsHHw5tLI1jJTkyDCiV8GDZExQEhLTYnLzbUWQAVDE
 X8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790705546; x=1791310346;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pq34Mt39TFECUFPArjmn/A65QZ8KuoPmDapBVD7nS/c=;
 b=X4CRVT8E98wudNXCAOCF4+xEhVlYOhAxutnfeEQaBmT0wF6aC3EnbPq4cWBDKyYOVV
 UR0vRgk/lop4CHV0iyCrSC0gCqQ20ACIfZZyPuSlYCPTXWm2P4S0nsxdyiLuRgIS37md
 sP2jfYygGG/vAWK12zlbawqr5eYUTLFnrs2zXyDuF5kc4kgo6i/cUETx4Fv128ANLkI8
 4D8JbnrOQcGVNnvSDFcJHOQURAhQWIepvIo0M2B4VgAFBel8+XBut1PCaUcIDPN0+8zR
 Bh1YqjLtDc+qWLW6uA7ht0kkf1rpY68Y4Iqs2YTGLXceJ74r2oUOB+5Wz/7/aO7w3215
 T1yA==
X-Gm-Message-State: AFq9FYLkHZ5OLHq2NaY/FmX3ulraqcw39mhP6u4SLVMRtc9bnKEfyo4V
 f47IXup7yHu2D8fVvJs9XCXN0UIDqUzvNPxpDY07Wc7/rHNXmRqzBqfviFGHIh4gs3ERtjFXTRR
 B74EBowPwz91gXvsR/ZbbDx2jyFct/cV8AOrZViLKpw==
X-Gm-Gg: AYBFou2sm2yNCT378hj2VGB7NOn4oIXMZW72fKF6vvX1aHY/vIlmgBtCSRttYKQfSHA
 gLK2rA8su2/Tt7r3lg7zNtn3aEow5YpEIoAe4h0ozH4ZzH3rbiyVtvU00kxz5yIM4BTYnNFVYMo
 LUy+uN50TyzHK65lWOqq/pIqRQGZiQ0t+tqFBRMWMjka2Q6kVDrmwWLPCvxigKRXA9I2jAh41Zl
 VCfVU1gOJcAzWcrRcMxzEyDsrvxyaZQTIZ7Jqv34TnSBMljjT6hmFXhp8g6M5ky6g0DHyFHxFIl
 w1vq0jIdZeDL91HCxZXUyMQXX+seNCiQL+GDus4giBmDML7TImlZRJy/Yg==
X-Received: by 2002:a05:651c:a390:10b0:3a6:6efb:a0e3 with SMTP id
 38308e7fff4ca-3a771744e6emr516341fa.5.1790705546394; Tue, 29 Sep 2026
 11:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260904-fix_skipped_ipi_init-v1-1-3f4e7a10efe8@maquefel.me>
 <972c116f-a430-4ed8-8b94-e4c1982e5f22@amd.com>
 <856f099441f717605de9be5456dde8c97bbd04d1.camel@maquefel.me>
 <arZdGzVgm9ZtnSm_@pie>
 <b40e05037fa322d747ab6b48f7e38838f38370e2.camel@maquefel.me>
In-Reply-To: <b40e05037fa322d747ab6b48f7e38838f38370e2.camel@maquefel.me>
From: Leo Liang <leo.liang@sifive.com>
Date: Wed, 30 Sep 2026 02:12:14 +0800
X-Gm-Features: AclHuK-HgYzQtOstlIBECF2YAkBq406fWSGcUaQl-8ebG2ZTTZobpLbAA4_2m-U
Message-ID: <CAC7DN2D29C_tqCfiBZPBc5BOM5Tini5G-hw6W_81cKwsLQY79A@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fix IPI not initialized in riscv_cpu_setup()
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: u-boot@lists.u-boot-project.org, Tim Ouyang <tim609@andestech.com>, 
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>,
 Michal Simek <michal.simek@amd.com>
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

Hi Nikita,

On Tue, Sep 29, 2026 at 12:58=E2=80=AFPM Nikita Shubin
<nikita.shubin@maquefel.me> wrote:
>
> Hi Tim Ouyang and Leo Liang !
>
> Any comments on this ?
>
> Thanks !

Thanks for the patch.
Reviewed-by: Leo Yu-Chi Liang <leo.liang@sifive.com>

>
> On Fri, 2026-09-25 at 11:38 +0000, Yao Zi wrote:
> > On Fri, Sep 25, 2026 at 01:19:15PM +0300, Nikita Shubin wrote:
> > > Hi Yao Zi!
> > >
> > > A shy ping on this patch.
> > >
> > > Thanks !
> >
> > Sorry for the delay.
> >
> > > On Fri, 2026-09-04 at 08:20 +0200, Michal Simek wrote:
> > > >
> > > >
> > > > On 9/4/26 08:07, Nikita Shubin wrote:
> > > > > If riscv_cpu_setup() is skipped we end up with riscv_init_ipi()
> > > > > not
> > > > > being called.
> > > > >
> > > > > But we still use riscv_send_ipi() in spl_invoke_opensbi(), so
> > > > > even
> > > > > if
> > > > > CONFIG_PHASE_CPU not set we still need init IPI and clear
> > > > > pending
> > > > > IPIs
> > > > > on harts.
> > > > >
> > > > > Fixes: d8810e1d4f82 ("riscv: Skip riscv_cpu_setup() when CPU
> > > > > driver
> > > > > is disabled")
> > > > > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > > > > ---
> > > > >   arch/riscv/cpu/cpu.c | 3 ++-
> > > > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
> > > > > index 3bec7c7cb6d..a65e6951384 100644
> > > > > --- a/arch/riscv/cpu/cpu.c
> > > > > +++ b/arch/riscv/cpu/cpu.c
> > > > > @@ -639,7 +639,7 @@ int riscv_cpu_setup(void)
> > > > >         struct udevice *dev;
> > > > >
> > > > >         if (!CONFIG_IS_ENABLED(CPU))
> > > > > -               return 0;
> > > > > +               goto init_riscv_ipi;
> > > > >
> > > > >         uclass_find_first_device(UCLASS_CPU, &dev);
> > > > >         if (!dev) {
> > > > > @@ -687,6 +687,7 @@ int riscv_cpu_setup(void)
> > > > >   #endif
> > > > >         }
> > > > >
> > > > > +init_riscv_ipi:
> > > > >   #if CONFIG_IS_ENABLED(SMP)
> > > > >         ret =3D riscv_init_ipi();
> > > > >         if (ret)
> > > > >
> > > > > ---
> > > > > base-commit: cc557af4553382f6f50e3ed62b9577054e7bc54f
> > > > > change-id: 20260904-fix_skipped_ipi_init-aa5575f55bc4
> > > > >
> > > > > Best regards,
> > > >
> > > > There are 2 other approaches how to do it in the code but it is
> > > > up to
> > > > maintainer
> > > > to decide. No issue from my side to solve it via goto. Obviously
> > > > one
> > > > big if
> > > > (CONFIG_IS_ENABLED(CPU)) is another one. Or move it to own
> > > > function.
> > > >
> > > > Anyway
> > > > Acked-by: Michal Simek <michal.simek@amd.com>
> >
> > I think it's likely a bad idea to have IPI stuff in
> > riscv_cpu_setup(),
> > but this fix itself is okay. I should have noticed it when reviewing.
> >
> > Reviewed-by: Yao Zi <me@ziyao.cc>
> >
> > However, I'm RISC-V's reviewer instead of maintainer, so I couldn't
> > pick
> > the patch for you though.
> >
> > > > Thanks,
> > > > Michal
> >
> > Best regards,
> > Yao Zi
