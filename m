Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6CDCA5FD4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 16:02:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9070C60B18;
	Thu,  1 Oct 2026 16:02:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YhiER3X4iptw; Thu,  1 Oct 2026 16:02:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C329760D66
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790870573;
	b=YKMNym6uXC8kNg7xkO+fQ8Id2+iriYWUCebSUxqa4pgvdl/X3gctIAYEKLCd/CWkgX7Y
	 9AFHsQJ6AdJBZ2MaGlx2Bbw0LxpmdCBVqUL5qOmApHHizP6VqbrqjRhH6ZClzK5u8aEcc
	 8MP50h9PEMusTdIAwYr27/JIJdT+NCu4EyGct0jYdGyF04d70x0vcog6KT4aHfaQC1KQx
	 Xzdzl8dgjNpq6emzEPMSE7BfDf/5gwu2RFxlu1fmNDOchXKgTVE1oC5N+CHJ5qa9JIlrC
	 oFfUio7XDVcKdCJZh786IPznKfDBwCrz8v59G1N2ir9bTwZ3SCrMPEv9rjHqEYZz/Fg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790870573;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=OApuC7hcd0CmhVC/u4sJDZT6mX5wyUuTntrVQzUmuXw=;
	b=oGpk9+qp0s8qiEPRtqwe04IMo8GcGHzi5F2g0RaFSwAPuFQvIuc3KM8wM1D/ciG8CN21
	 TW4MDTSW0HerRErFj/cvnWtazKfom6+Zfms+EZCc0o2jusl/4EbVlNNpR80kJyyaE9inK
	 YVP2PtOELoEtAnFNUh7ZSJyoNjSEBle6zPtw28y8+5Lie3pAwOh96lH2Pl2xBCBVSWYDs
	 WDyhrIOC6ntMvQPHqL54mMDrydy/aavRd4KEg8Px6PY+9RHJQ35hXOs26Eh8c6A5P8uEc
	 A4J4co2CVl14fl8XqUs9hbsfr+JfPJYhpLidm/pd5g5AiSubdKxVw6IRjckWYCDFEkQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790870573;
	bh=OApuC7hcd0CmhVC/u4sJDZT6mX5wyUuTntrVQzUmuXw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w1aHgjSgMkgp2rHHMsyzV8dX3JyN6Lusliu3aDqihOb/c+O3jZUJafcYdCBNp6HSK
	 R5K8wPcestS6VIEET0mhPe/ws8M6AcKQ6WyS+TPNi1BeRJNEZja/hl0z5t8zRjkKrw
	 3va0fEJfEy0HCxBXX8KRepBYv9Bj0V3QkWWxhKJfapk/BhyYaWkir9quOPy1pdk7k5
	 5M+OaY2etffNPOhbd+26upk5D0imVy9BiHD5qa33nGEdVnh6HzlWgRmwlOlGl+v/y9
	 hXgUqWY6Xx+Axera3x44MvrJ0OnkKdsNRkLlXn5HBCikG81UUVCsYvp6MrnCVMBaWY
	 HhALuv7XHjxZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C329760D66;
	Thu,  1 Oct 2026 16:02:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B3DAF33B
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:02:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9900B81167
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:02:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7Nht3dsUGb-W for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 16:02:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8B79481090
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::19"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790870571;
 b=fkAjDTu7pyTExp18rqdl7VOJ87Ztra3uJ0AXtXFoE531TVYGQb1uSRlaSi6d5/53Er5O
 MPRF+bCXawgTUFKCa/ahoP0qslk5Q2W+s6BD06A7+9AnZYDxAQD3qgKMxlapeL6rxveac
 ORGG18bYFO6O7adcJTDDeHyDO1293gVN1QLDmUk9kp53NdMwCg6Ani4FWNNlGaVdXMwp/
 LBD5/R9KAJVMUK12Ij7CLBr/qjuxbveIZyIRAOozROhq9zbVxhDs9o3XFLVsZZcvDcAEe
 k3AipnUxxr5W5cUOeQEA8MmIfp0XoEh+/IaYDXLNAhYYgQTUQApFDMQOdcusIzLqvtQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790870571;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=OApuC7hcd0CmhVC/u4sJDZT6mX5wyUuTntrVQzUmuXw=;
 b=rlj3hC9U9loJr0Iqd+SmQLzmZXCoErROnf91lwJO0PDQ600fVvqIQQcP0oXCLOXQImLY
 Lw+S8it9uxjtytxtCfSNrH+q6e7r1kah1sTsLo4ZKL8GALfvkCpXU8jjW8w6B8KKvsqPi
 eN3HItKnAFXCoBKBOPCUVGzDmXLYRU8CBscN/8TgYtRM1jT/ASCWRY6EvnC/WgOGW0OqR
 xJkL8RCYmcqHJvLg2yFoOYlG32z7K/VCMM3URKhllEsWKsXcDhrK/oOmqq7VaoYgsumkj
 OTkbnqZ9GpuCckhK3lChl/BS4qh8uVxvvWXeCjgXZlWXwmmm3aynx+JyTugWbAvzuGQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="MgNzJGq/"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::19"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::19; helo=mail-ed2-x19.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=MgNzJGq/
Received: from mail-ed2-x19.google.com (mail-ed2-x19.google.com
 [IPv6:2a00:1450:4864:33::19])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8B79481090
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:02:50 +0000 (UTC)
Received: by mail-ed2-x19.google.com with SMTP id
 4fb4d7f45d1cf-6ab0d9260baso7829465a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 09:02:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790870568; cv=none;
 d=google.com; s=arc-20260327;
 b=skGXasKCXxLNXXQYQsYh3N4FKvU77TWnb7uCzsClxiNeciPX1JxFqC2oNcF+/PUo/7
 gceaLuHFTMWm4R7poKVLhstNfc4Hm6fRDWo3+I1i+2TPWEVVRjZlL/Iq1QnUhtVOiqNZ
 UCWIhpa3HBZXBBqJq0hq6TKNpa+jsao2/BmRj4n40264ya8j9g6j2sYHzQuV6eWr1TnQ
 nzd7FbSX5/n2g5UAiq4844mZFgp8i1sr/snUYzLWUN2gfYaEfeXqQea3kLZG4gvsaqvJ
 3I+FTRW4KQ65KtKoHwRq7LzaRbu0cGTr8bGKSuTSDFlzzhmziYeLHb2ZXsRxPubrXoc9
 4vUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OApuC7hcd0CmhVC/u4sJDZT6mX5wyUuTntrVQzUmuXw=;
 fh=zLLB3HRm5MXK2e1qC2tA+0hdB8rpVY3IVIdskKE+xtc=;
 b=dp4od3vYPyJ/rxR+ghouA4XYYvMvomNmzKg24qp0bfZANrwBLCt5PsXkIxjaHxy+iT
 kCSuFWNDmC18/Dk6mJ2AEstkOI/t2KfNfe2jlTTo7Tdxl49K1WV2dZAuF8IFSpH69tuC
 yE/+dNGWZEOvPOzedNRhts00/TMwY7MBSUpcNxsPfrehG1C+Fj4jcd9oQxi4VXDNUgLc
 7pq9oYuBb3IfbqCO9/8OYnpI08OFrSw7xQ08sxCX5c81o8zQMFHijH3qGBOgIMZ6JpCM
 hlF2/zJyJfvLrFvf78fwMvxCvntPhGSjNZ02hRRmRm6++YcxDuy8jyqBk8CBa9KHkO0S
 eYQA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790870568; x=1791475368;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OApuC7hcd0CmhVC/u4sJDZT6mX5wyUuTntrVQzUmuXw=;
 b=MgNzJGq/XDKyP5ggLeeNfecSIAbdXCKyBV63oSkUn9sE0qXWj7wDPtfRi3PfNxDEKm
 aSv6lweJiNIU1LcocI4pqLnfyUXRVN7JP+vGoo5alVFON2vq5JWE9X04lzpX3b+pIzIZ
 ZX5edOkLPzNMuHIcBT2czonYRWTuuWMZDniP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790870568; x=1791475368;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OApuC7hcd0CmhVC/u4sJDZT6mX5wyUuTntrVQzUmuXw=;
 b=f4472mvP7b1noFtcSjTvkvNqOxFqVAceuJHc4CAlPZmY5TXgL78eV+dclIw4kxCoqc
 GNErt+BtzUxs7RENq4HSwoe0Lyu8pBZto3WQKDdOJD8RJLT7PT0uatY88pJ/6+dPVpzp
 CG/LnUXZIX4cm54yzIzYGy2dvU2vCFPLL+HIM8tyUFsUOf/75JNDCecyxc7jSibDbgoT
 EeAihtZCE4Om2PG5qFE1CnJJ65CyG7lN9wXCc3MfZvTJZS+eJP03Hm1nGAHa5Ygw9cY0
 5U58usBb6bTdMAQQaDIuMcSu47wmPepXoSVt6dsEQsLG77AED0tGad3y644wAGeoQwH3
 9w2A==
X-Forwarded-Encrypted: i=1;
 AKwUvBy+K6/Oj6OKQ5btQsFhrj9JuKotmSEARifSv3mLKwle/HWaTOOfsGJVf6RyVvZFHGHwhSJDxQA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK4ALsoo9OCmu/tiEuztok6f8HdoiYZJgGNHQt/VqyJ5TP5HUHX
 JPh3Nb3f/OWC11WRB2P4705H1A49Tq4W+bgUMLy+t4GCpxWNegDGfHdjLPVYb+uq1qphC4DmuiT
 SW4DX7L7eTW7+wjQep88VB2CUiUGzBpMbnBTji1k8
X-Gm-Gg: AYBFou1ClHggaKb1w/3D/MU4HBl4vt6IVWsOiaIhJzRbMduu3o2iofdDTmCMJlGAOZ7
 DKrBMh3S1V58J5b28F3Dv1s5tQQya5QSU6xzD+J/vr171HftcUHxFAKflBI4f+VWYsPEU4x+PZL
 jue5tuH25sy0qmoUlMflqBV3YPObeeLo8qOvJ1NMN/j8Xjaj82Ysuy2JOSizPewQEOUTbBPxuzz
 +NgVFv/CrmOTy6YepCfK8ho8z7nbyNu8dh5XjJmHs7Yj4NPoDYhfj6/9PTZZ3wATe1DgeUtovjA
 IcnPZBm2hr2/LiB45mJdDJ7lRrNY99VR2KSxXDEixe5nsEc/Dx4+VZum
X-Received: by 2002:a05:6402:4552:b0:6aa:9fef:641c with SMTP id
 4fb4d7f45d1cf-6ae1992adcamr3698889a12.28.1790870568057; Thu, 01 Oct 2026
 09:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1790626459.git.daniel@makrotopia.org>
 <820120100ab98d856504b7edd2c5d86a09e2723c.1790626459.git.daniel@makrotopia.org>
In-Reply-To: <820120100ab98d856504b7edd2c5d86a09e2723c.1790626459.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 17:02:35 +0100
X-Gm-Features: AclHuK8p-bUiZg4uNFElaLc9qspUzg6oW4vgVR2u8x5e9TGESXkZjC6uuvABWDs
Message-ID: <CAFLszTjJ1O7JNFTRoNafnbL4NK-pGM63+Y0Mc-rTamUq0ONVqg@mail.gmail.com>
Subject: Re: [PATCH 10/11] test: boot: imagemap: detach UBI when the test is
 done
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Kyungmin Park <kmpark@infradead.org>, 
 Heiko Schocher <hs@nabladev.com>, Simon Glass <sjg@chromium.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Weijie Gao <weijie.gao@mediatek.com>, u-boot@lists.u-boot-project.org, 
 openwrt-devel@lists.openwrt.org
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

Hi Daniel,

On 2026-09-29T00:04:16, Daniel Golle <daniel@makrotopia.org> wrote:
> test: boot: imagemap: detach UBI when the test is done
>
> The UBI test attaches UBI to the sandbox NAND and leaves it attached, so
> UBI still holds a reference to the MTD device when the test ends. Running
> the suite a second time crashes in mtd_partitions_used(): the test calls
> mtd_probe_devices(), which rebuilds the partition list of a master whose
> partitions UBI is still using, and the walk then follows a freed entry.

Just to check: mtd_del_parts() checks mtd_partitions_used() precisely
so that it does not delete partitions still in use. If the walk
follows a freed entry, something has already freed a partition while
UBI held it. That looks like an MTD bug which 'ubi part nand2'
followed by anything that reprobes could also hit. Please can you
explain what frees the entry? If it is a real core bug, I suspect it
should be fixed there, with this patch only tidying up the test.

>
> Detach UBI at the end of the test, and again at the start so a device
> left behind by anything else is released before the partitions are
> rebuilt.
>
> Fixes: 05c1fbbfa79f ("test: boot: add imagemap unit tests")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
> test/boot/imagemap.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

> diff --git a/test/boot/imagemap.c b/test/boot/imagemap.c
> @@ -592,6 +592,13 @@ static int imagemap_test_ubiblock(struct unit_test_state *uts)
> +     /*
> +      * Release any device a previous run attached: UBI keeps a reference to
> +      * the MTD device, and mtd_probe_devices() would then rebuild the
> +      * partition list behind its back.
> +      */
> +     ubi_detach();

This only helps if the device was left behind by an earlier run of
this same test. Linker-list order puts imagemap_test_mtd_blk before
this one, and it also calls mtd_probe_devices(), so if this test fails
part-way, the next pass crashes in mtd_blk before this detach is
reached.

After the next patch it also acts on freed memory (see my comment on
patch 3), and the 'ubi' global is left holding an MTD whose udevice
has gone.

> diff --git a/test/boot/imagemap.c b/test/boot/imagemap.c
> @@ -638,6 +645,7 @@ static int imagemap_test_ubiblock(struct unit_test_state *uts)
>
>       imagemap_cleanup(imdev);
>       free(wbuf);
> +     ubi_detach();
>
>       return 0;
>  }

This is skipped whenever a ut_assert...() between ubi_part() and here
fails, which is exactly the case the start-of-test detach is meant to
cover, and wbuf leaks too. Please can you move the body into a helper
and have the test function always detach afterwards, something like:

    static int imagemap_test_ubiblock(struct unit_test_state *uts)
    {
        int ret;

        ret = do_ubiblock_test(uts);
        ubi_detach();

        return ret;
    }

That keeps the teardown on every exit path, so you can drop the detach
at the start. What do you think?

Regards,
Simon
