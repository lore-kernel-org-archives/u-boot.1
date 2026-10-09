Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48CECA5FED
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 06:47:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E2F680F66;
	Fri,  9 Oct 2026 06:47:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IT-Q5MQArJDj; Fri,  9 Oct 2026 06:47:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B6CC6810D9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791528466;
	b=sPCCBPftHagkdD/Ffw31lpQ0OtEOEWRjt+JdIj7XLW/3uN2mPNBZrazWBVexL/817rLs
	 GnNuTE4qBa59m/HvAqeOOLoZgNDgPfymJq//BQ4TzNPAya+ahTUZzQj+eU/xcecQI/1l0
	 DbIahqutowm00sQecg9bAA+u5KfhX8xfs0p8bbsuFl2MU/ottI306lpzJ3Ra1ojwsH0IV
	 YoW5KZr6LVtcr0QnFBwSediNowDhxiZcrYki1KVzpGQKqQoe0zk05O5UIU5aH8foISsgT
	 YiyDN/MKILIyaE2Zboc6bje+zyatQXXx+HlBEEhEZ04zwTPnPTU7qIu5XOhJ7bDBNhQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791528466;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=EXiaQejvcQrW+jtIUE3WC0Vqf+XEjdMCk01wHhJF97c=;
	b=Y3OIqUPr8RcJFfBvpU0MBsA7D6O8O6BgzyqB4zkiqWxLf1HWezKERcpGpDfVKK+nNFGa
	 W0nIdoBt56j2ToI4jTd7I89XvlPsaM1eEGvV96q+axELmUGY1zrvF4km1TODO+e//unr8
	 ES/awGxQ4IJ1lxaSsuRyrRyyC0UGAaqFl4kWBJ0fdb/HCLQGYvF8EehCyr9gCv5E5uR6Y
	 /wQj8CUpOR5DTwoIPthl/+Hh9FPHpgfBmrReQQgiIYPOB10G/RZY1aceCOXuDEKO22JC6
	 2Fn9ZG1fte68p6C/8Lp54F5nz2aepvZUxBPyQETteHEPJvUmPQ8tI+CC0mCroqosrpg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791528466;
	bh=EXiaQejvcQrW+jtIUE3WC0Vqf+XEjdMCk01wHhJF97c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zMfLqzfDEB9vn7d9T3LPs1JWx7eqOgLqTVhXEWxz1LmQ1jVLh1rxzp35a/4ALK5mD
	 t2r8+NSDQI20qojIw3NJbW6A32NLtBtDkR4sQEkZQnLVrSIPidCLSIssSp2aUBB2gC
	 wZ1YRCj+6lUGa9F8JmLzTCzTY1Ig8BFGP1hJB84jCQgccyGs+2sqBp7cc8u4DDXsNQ
	 FEsZTWahz5Ag8KEcAEFvjQyCZtE/ofL6wg7voVvPTzQbrP16bmfYZ/aYclnpPbuUZ+
	 ML0/VOUm5CzsDFsTXUFHdIHmYSq/kBWKIUFJn0OJTc2vJZReuwD9+jhYzk+Foa/xI7
	 uJIZXXL9liPPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B6CC6810D9;
	Fri,  9 Oct 2026 06:47:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C8C8F1C6
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 06:47:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BB44C4009C
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 06:47:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id unhZY_47pRfG for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 06:47:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A897940061
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::529"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791528464;
 b=HrZo+4bvCWb4GupirZskjaKGUKJDeIT09/uyHWmxjruXEEVui2/4kMAjocaInK36VCsV
 ZA/CY1LbohC1OySrTyyqERKTNiYbtT5+e+R1jF/CxvJkGCVQXH5DiOaloZUccT/ZbDwu/
 H778lV7+CbJNAgA0d9OXfmf8Jo6TnqyZE09Ik7afpfnyWqUPYquddbzYuA6WWRFCtjG9Y
 xnxvXIzQ20+1Os+D88UftyrzW4InEentjx4+74QFKBUfA/zUY+Sa0CBHpiwoBoFLj1sSB
 iIVDDAuKLaaOty1v+E2P3opYaWhEMwTqshJM9e/91te+eK+ehR237QPCAJFm1Kridiw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791528464;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=EXiaQejvcQrW+jtIUE3WC0Vqf+XEjdMCk01wHhJF97c=;
 b=VDA8Pr5ys7/sdkmH4WwDK4NDJpiKYywkGvnJ48unPzDnH5WKWU8pq0x+BCovEAOFmUTK
 bftqr/U9earowal3PnRdORssWBQ9hWjnfbnhT6z/8rsyHw/BbZ1OcMqrrpj+33UEWGASt
 mYz+6bGP70yHqwW6Q1Wi4dG++4ypJTbEM/Bn8z17o2YuDuvofnLwpGLEzPxfOFdBW7cKG
 d+XBfHLYA1SM6rmbsE4afWhGWDCK79oG9p6PkeCRsiVsiKk5K6m7A6ewi4qy9eg0rIQwV
 +EQG9momMyVMTGMeca5lEEOc6GcdOMbwGMjvXLedlZFq+RxuFcmab9PDTn/jDc5/m8w==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=N4oKaZZX; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=N4oKaZZX
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A897940061
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 06:47:43 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6af9befd04cso7916655a12.2
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 23:47:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791528461; cv=none;
 d=google.com; s=arc-20260327;
 b=DEkVCW7fig1xERdc2DfIp8QTMzuvV3xv+s0kwnWttfyf5O/T8vTQ3rfAbwQN9Jlbf0
 jxU7/yfQPnU0l21Qy/ZCa5+hHtMdKRqBKlZdy/y8yGEU7VTVXODwXGKUkquBbcAWTIRI
 ZFsQVcVjwnPFWHSbhjv6Fp8jdK0C83yQ0WjlPbUh8Fu+ESLXeqsbL4INXe6XW5CB1mn6
 USABg8WfHw6yeb/7sQURea+V3G/XWlo6yLYWgFatCcWKe5QbVI7+yl/VrR4p/d13JvN+
 Kc8luyQLlDCiSkwRcrIZyMTL94JHfe/zDH+aZw5likrCvAP2pJAybQDp+M09AHZH6w06
 ki0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EXiaQejvcQrW+jtIUE3WC0Vqf+XEjdMCk01wHhJF97c=;
 fh=mCKit9lMP75JtPrBLEUv24ZnGSqqy0L2CXZei56lwvM=;
 b=J8hzzGTTGUrBXXNfbTXBhwFPiDTAtZ/HK6Kstr7LKhMswukPLulNTW6eKvqT8plFyz
 M6pS9Cw5utVefrvFFvMs/wxj3EzLepYSE7aI3Ga+WDuu0XUpEhYNKdX+VwQ0FavDgoHw
 stzUIO02suvvDTpgdmmdEgWXKOP1x0LDuyoe8FVfIL4oF6l6MM+N+5+4LiX08mTOMgpL
 tFzjdW4zagtuKF14nnGedAaG2IXA0gKQwZQjMM7gYYFOxqN3Z0xqsBs7ivEmTi6hMG6T
 5DebOHs9HCNd/42TOuAkFBC2pMoFEwYNCDHogvMWiZy+LIo7EL1X+64ILr+b8Pi3IuNf
 a1PA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791528461; x=1792133261;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EXiaQejvcQrW+jtIUE3WC0Vqf+XEjdMCk01wHhJF97c=;
 b=N4oKaZZXkqibYSsL5DW1u3YJtvoKaz891VKK+9LobA2OzH2KlWL7cg3RlgbwZmDQOh
 +gSZnDnEpxd9CwMdbOWGcgpVRY6fVXZFUc/yvICzfIytXFgUIcIyvrGuLhaMJ6OZfzst
 oLSSWyxbEbWZzhpMOZo0ApzRquv4spO2HDbsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791528461; x=1792133261;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EXiaQejvcQrW+jtIUE3WC0Vqf+XEjdMCk01wHhJF97c=;
 b=oHorj6naPOSAdW8VoGYq3uUwLyi+Bzw+kB8uQ4yZlRXRzs1AlLb08AoSDPeel6hX2k
 VNG1iKkTXQ3yFobohr38E6yd62nieY3IUZ0bVgR23iCn3DrDzjx22aR7W7jFBimFisIP
 pbpcQxRohcHtb8Hf5GGzGJhkopcq9Mqiu57nFubYADkGg+SDLVnF8GmHzXKdC21pFueT
 rN2ARs0WoL6a+m1SGwa9x7zmFcmlPAEKipG0fIQJ6l/MotrSbMX+X26NbJD3hJ1/JXcO
 Dzcwrh4E7OQJi8gIL9Hjr0I6DkfZpSESTKMrtKEtSegZ7cu53alYXRzSZQjVGLcqyged
 T34A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzN2Er8WgAnf1CycCZ41Uo5pFuNZGyhHaTVaRHvNq1mU81cKJW8HthNjqFZxCatpzXj+GUzmbw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIwld+TR/Y0pqSh1mrGeTMjfRToWg8SkPp1R1QakgyEGXd9zXmc
 JGObmEa0QJI6VNrFDjQ5OqRDIpliBo0XNnS44qzGuPBIml5Ir2GRYIiAn5P/GuuaGSRn0987zn4
 rwbHOtzg+VwMQzf3ecCkabkR1CtLiCeQhz+Rz48uP9Ij4j/8y2kiKDqyX
X-Gm-Gg: AYBFou0Cpu3YvRci8afodMQWhiOZ0v/uee7l88jo2tjvsdirubwZeZQ7eyQu/2AGy74
 4cLrY3aVhgrLRDxKCGWl0ieIOjthNdjZADL6yfq4/N/RXA6/4H7oMKKVY2Q/P/0rGqn7SyVkDmW
 qxASeIf8A4LUyhnmKd4hkf1CWfqLWL+7gvJ4LGmPBpZ2mPnTPcKvADYUYLxsyd1PC9xbDWuV7LO
 wBJZqPJXvuU+y0YeN+OPs0fKz8fKnZjZ8anh7Co4tTt98K56OE0sqX+ooH1kiJRh4UrgXab4Odj
 Zt3YWUqU2x/3J66y6vD2giayj3Wx02/gdnQdIkb5BNW2+2bgCr7vvhA=
X-Received: by 2002:a05:6402:2114:b0:6a9:aff5:c6e0 with SMTP id
 4fb4d7f45d1cf-6b17c2b1182mr593389a12.17.1791528461149; Thu, 08 Oct 2026
 23:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1791381507.git.mehmet.fide@screeningeagle.com>
 <0dcd337468ebf2c5baebc91c32bbf990422c2d32.1791381507.git.mehmet.fide@screeningeagle.com>
In-Reply-To: <0dcd337468ebf2c5baebc91c32bbf990422c2d32.1791381507.git.mehmet.fide@screeningeagle.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Oct 2026 07:47:29 +0100
X-Gm-Features: AclHuK86mubLyCwj2vTlmxMyazO020olO0Ng6vNJtR83TUvHw54cKkmHF7WmJ04
Message-ID: <CAFLszThvoDY2imKOv_A8W7kxyAJJjNNjRrNP5Vy5Uht6AfwDOg@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] dm: core: add ofnode_get_alias_seq()
To: mehmet.fide@gmail.com
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Stefan Agner <stefan@agner.ch>, 
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org, 
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Mehmet,

On 2026-10-07T14:45:38, Mehmet Fide <mehmet.fide@gmail.com> wrote:
> dm: core: add ofnode_get_alias_seq()
>
> The sequence number an aliases entry gives a node can only be looked up
> for a device, through dev_read_alias_seq(). A driver that has to know
> the number of a node it does not own, one it reached through a phandle
> for instance, has no livetree call for it and is left with fdtdec.
>
> Move the body of dev_read_alias_seq() to the ofnode level and let both
> of its variants call it. No functional change, so the moved lines keep
> the ENOTSUPP return, the #if and the fdtdec call they had, which is what
> checkpatch complains about here.

The checkpatch remark is for reviewers, not the commit log. Ideally
this would go below the --- line

>
> A test checks the lookup on the live and on the flat tree.
>
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
>
> drivers/core/ofnode.c | 20 ++++++++++++++++++++
>  drivers/core/read.c   | 20 ++------------------
>  include/dm/ofnode.h   | 13 +++++++++++++
>  include/dm/read.h     |  8 ++------
>  test/dm/ofnode.c      | 20 ++++++++++++++++++++
>  5 files changed, 57 insertions(+), 24 deletions(-)

> diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
> @@ -1233,6 +1233,26 @@ ofnode ofnode_get_aliases_node(const char *name)
> +     if (ofnode_is_np(node)) {
> +             ret = of_alias_get_id(ofnode_to_np(node), stem);
> +             if (ret >= 0) {
> +                     *seqp = ret;
> +                     ret = 0;
> +             }
> +     } else {
> +#if CONFIG_IS_ENABLED(OF_CONTROL)
> +             ret = fdtdec_get_alias_seq(ofnode_to_fdt(node), stem,
> +                                        ofnode_to_offset(node), seqp);
> +#endif

The two branches handle the stem differently. of_alias_get_id() does a
strcmp() against the stem split off by of_alias_scan(), so the stem
must match exactly. fdtdec_get_alias_seq() just does strncmp(name,
base, base_len) and then trailing_strtol(), so any alias starting with
the stem matches. For example,
ofnode_get_alias_seq(ofnode_path("/some-bus"), "test", &seq) returns 0
with seq = 3 on the flat tree (from testbus3) but -ENODEV on the live
tree.

This was mostly hidden while the only caller passed a uclass name for
the device's own node. Now that the function is public and works on
any node it matters, and patch 5 depends on it: it passes
dev->uclass->uc_drv->name, i.e. 'usb', for the PHY node whose alias is
'usbphy0'. That works on colibri_vf with the flat tree only because of
the prefix match, and would fail with OF_LIVE. I think patch 5 should
pass 'usbphy'.

Please can you also say in the header comment that the stem must match
exactly, and add a negative test with a prefix stem like the one
above, so the two implementations are tested against each other?
Making fdtdec_get_alias_seq() check that the stem is followed by a
digit would be a separate fix, but worth doing. What do you think?

> diff --git a/test/dm/ofnode.c b/test/dm/ofnode.c
> @@ -523,6 +523,26 @@ static int dm_test_ofnode_read_aliases(struct unit_test_state *uts)
> +     ut_assert(ofnode_get_alias_seq(ofnode_path("/i2c@0"), "spi", &seq) < 0);
> +     ut_assert(ofnode_get_alias_seq(ofnode_path("/some-bus"), "testfdt",
> +                                    &seq) < 0);

Since the flat path now uses ofnode_to_fdt() rather than gd->fdt_blob,
it would be good to also check a node in another tree, i.e. a variant
using oftree_path() with UTF_OTHER_FDT, like the other *_ot tests in
this file.

Regards,
Simon
