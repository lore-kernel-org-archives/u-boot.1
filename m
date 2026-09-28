Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64999CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 17:13:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2AC01606D0;
	Mon, 28 Sep 2026 17:13:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GdPnZcIlRhZg; Mon, 28 Sep 2026 17:13:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4428A606B0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790615589;
	b=limCxjZIG7XhwNiHXu/gNnSKGZqyszKVdbEXK81l1brlmeJp7WiRyYGZ7ArJ5I5QbOBj
	 vP6T0gKksFi4rBYLR8xwyPOup2aEVfqfSSXQYKvfAX8jHziWptQerl/Q/KGrcj9M12p1D
	 vBwikpvDgQpQy4ruYBsNtoCV4/5tB9jPK7lrxtxjGIaKyieTAGttoCd4c5frgi9jsz1YK
	 x9wKIRT21qVT+TbwaYCKIz5iL+6jPzr2gtnOCc0kXlRlROd9FGMnL3Bx1YaYht0FvuGV9
	 KZjB+Y2xcaKMfP0FoKhnzV9azH5u8n7c6ewlF9NdnZOXzOQOAschWvJeRlCkdXH3+lg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790615589;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Jy/gwIRJQs8I071MnhgbDwnWbuxL51ce+fMXp8YU5Sk=;
	b=GhwIiM2HgKFEFWstKzH1LgEjyvUKI+HYue2Q2C5domOxj8fQDp+3um5oXRrRQYi38fBr
	 tkFkSe15bgXUzpObnYTtiCCtiCyEXkk/xwyRacccTCMaz9jekjYMTKh7ufyIZ5s6liFav
	 +j5Vgom+CYDaFSeszQMvM+SDq82LgN0mql1DnCIaH2DLnMHkApELAIqaqR/03IicmxDWP
	 w9inSgdO16iO39gWEkelKzswF77LjVQH6ONuFnFuJH1+RzwmsMPRbNq2GDMzuW/h4XFaB
	 AKCA8yPdK9o77QR09sxnJ3ldkBIfJgy5clcBJW0pYJGCq6StLWGMmhD+n52XpV4aYSw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790615589;
	bh=Jy/gwIRJQs8I071MnhgbDwnWbuxL51ce+fMXp8YU5Sk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zoce91YAKW2ZjD6OVl8kdSxuEbJCTWFJXabvrqnWH2BF6t20iC2Ci5+DwQmaX/aCD
	 S9G07E3+iW8IfxKhGC9jDK4jAHbpQ7koEcz1OcDcDgEPiuxhACJrgVFoLrJjz+jbTQ
	 mNzmRuOMnaN69hpZL08Ec21IDKuXktTDg72g9mHfqK2/w7w6zTUjN/tp5ZuLIePp/A
	 GJI24VhejO0w3/jWMGpjeCh9h+/m3vbYPUaC8NvyPgF4+jMMTfONC1FyoYQt8di1O7
	 Ah4YeC+QAWZvA2IMnV6VtY9l2KUmDDJXkrzSpd+S6UR5RAvy6SO+XgAjYgdJUWkvk6
	 /by4/cmsRfW2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4428A606B0;
	Mon, 28 Sep 2026 17:13:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B549F2B6
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:13:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B3036400B4
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:13:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9WA5lQgigY8J for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 17:13:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 9CDAC400CD
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790615587;
 b=dMtVCDrBG5mtF/q5GM6tUlYQuwmYrtWcydl+o+Y7R9SUT56Wv+/WNAup2Z+X57VSWudy
 9VASsFgv8Ouzn2PaFxWXepIfqgAalrqNQZF1LXrTLuaKVk3oDuFeVw6YBT5FkmkV0OG5o
 Bzx7xRVnuYTMrYiTa608wrm90Nwle5yaV5qDjr4c6PFSTExEPYkjk63CyjIsJgQhXNpiX
 ej3kjKnlfe8bOMX4dITjdpL+ehrqGnihKIo8SDgaa1r63+WmtFVwoF1D69tdi0dm32ASc
 5K4JRM9JG2xa9C8T2JR0ZNb/rxlgxpomqr1etZs8jHy5bEk5adFCJawkyfgz/P83G5A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790615587;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=Jy/gwIRJQs8I071MnhgbDwnWbuxL51ce+fMXp8YU5Sk=;
 b=SkK9mRRbplNanC9gha19PGRGepI/DLI69zgh+j2TJ1LGflOmCm8FT5lNXpIyYtzGQagp
 IAnDP1qz5D3x0fPIE/kjXzskBiz2vJo/lXYsOMb8aoJtA8ZpnaT7y2W2JYgUCd0myj1H0
 zCHQIOhwYuv3ged03e5XJlQjlPXnh3ytb8btnWdHFyF8pyI0X5IGkZSk23JznG7lgCHCh
 jUC44kCCCmL3CdJEpA9RVSkCyAK99g5CnDSu2wtBSiTGLKMIzGj/cdI37gff3yfdq/Jvn
 14eueuQkd2P9oNybo3KVbva8ZGv24VuXwmbcA1tGPsvq1aOUoloJxsbJyM6CvwJX10Q==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=f9fBC9dM; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::e;
 helo=mail-ed2-x0e.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=f9fBC9dM
Received: from mail-ed2-x0e.google.com (mail-ed2-x0e.google.com
 [IPv6:2a00:1450:4864:33::e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9CDAC400CD
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:13:06 +0000 (UTC)
Received: by mail-ed2-x0e.google.com with SMTP id
 4fb4d7f45d1cf-6aaf688ebb0so3623908a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:13:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790615584; cv=none;
 d=google.com; s=arc-20260327;
 b=iIpbMA7OTVuXEX/1EXB8GDX8P4cJFXb2OucyYknPLOKbHDZc9n/zH/mo+AWAC3iWX3
 DTSvQJwZfLzboqZpD9R/GUzpH2q7BMIraqNSc1y2mPPE8yya6YILpaZVbWWjPrMKzdNU
 tGgxC3a68ePnWM8e6bS4Ahkijpf211K/WPorATvCGPtC+yRk40tEnMEEL2edeOnvUZ5T
 2S2ZP4gYtL3V9C/jlO+f9xE1icg40Qmo990kninsXoJx+APGqGbwzvOp8ZuAAcTD7hgo
 vxKS4kn0XIUCAcZn/2EsofqKytzNusa8Rrye9SqWeBjzuuFEOyF/vcujCd35S5f4Oi9f
 eXSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Jy/gwIRJQs8I071MnhgbDwnWbuxL51ce+fMXp8YU5Sk=;
 fh=durgfX1b4/1SnC3pJJVYM3Gc1F35eR4yNe+Lv0h5pxA=;
 b=NXfHyjKptI3I/Ey1mUMuIqETle0Sfm8CmPNCG8LQ3G5jiBbqw6c98WjttP8FZviysu
 xIQB97p/JOfno8dZOVZL/Zo8/RXmoXv0/k1XAf/xAv4B3ufjQovB08nUwWEY/nUhVV5X
 fsQlzCew6cErFXagMyOvy9p76DZ3F5sg7VQ2nOBPVgZUYARhb/HI9o0Tvc03fXzy09QP
 3E+kNja7VIXyVRvZ0uohixdVnYB4iYZ3a6Gr3zoF0IV03n5yN0maKYlcRgNaooJuhTSf
 vOAaITcVw1hyjELnJ1j+lEtVTHcYCMuSHF3MLCjCcj9ohr1w74iQkLbA4i0Jg0qVUWdo
 hwJg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790615584; x=1791220384;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Jy/gwIRJQs8I071MnhgbDwnWbuxL51ce+fMXp8YU5Sk=;
 b=f9fBC9dM3gsI/ymQ+Qn4EdCRKxJPb+nqdu7FHjGGAOrR9zaGXDIoynpuRAMCOJxg6K
 pFYqiinN3YZxbBQoB/b0V38FaowjWXrlmpEtCjcunumeXQ14RR8ycwHikI8EHIWUyFwR
 os0gt0idLAc4IKzw9HHYvDGDexJNto4+7l6UU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790615584; x=1791220384;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Jy/gwIRJQs8I071MnhgbDwnWbuxL51ce+fMXp8YU5Sk=;
 b=033md0w/gZjpLxgRtLolSNjUtrPGSslFcyjXVYSbbCIi7LKSuUM+HJa4nqLA097ihC
 sSDugMxhOpm8/WAG2WU4VIrjiQ9J6aRxEHGLqMZAmZtqwgx4LgSHwCCRpJfNtzdN88EI
 FqUi3mH/kiP8w/9PIFnGgkG9rCHlqLQyxh70tUm0tS3J3DdM2ShRyq1vHA3tI173r2Rt
 aDeme9/A9PtozcZBeYDB4GUaDXGoeF8Tq0+ZoNxwz+rO6ACggSY6MD7dxyJnMLpZmwTG
 040Et2zMjchIGZL6so65334eSOoDfqfn5XuhFMpRnf4bh7/YE98Czc+1K3s/ExQYKMRx
 eRvQ==
X-Gm-Message-State: AFq9FYJPS1Icy5cx1CDmv3R/ynWuvb4+AY6YYhi3cL9A91Qx9MMyfmhH
 W0oE9KN05bEwI9n45/sqRQ5iDWV/uv2hlfJ8Kr0vHlv48o7JpA882JXY0icQHvzXsP5GtJC/Qgf
 eC3ByebMD5bEXVOLnt05UzTfvxwe/5FoPb6W1n1pr
X-Gm-Gg: AYBFou3pDc0xDSlcTDbc34fbOYhymKS9gwH0gAoNBHiHw+v1BI1Z6Fv0flxzP9Xhg1B
 g9AK17J3vCQeXmvjEEihT0iLW2zX/5jIzDbYMtVHMpK2EZc843ZX61eeB1R+gh3xYeZ7sLsMVqK
 BARSuIArfI3cA7bxH0cvD/M7QVMSG/5oTkf0ZoIxFXcbZN/8Uc3Fqyk0Vb/GjGVYfFpb+Y3es2/
 P5xzitf1CnyCaYyZ60Dw4AL3XBPkusjjuEIT/pH4WN4IS8kE1gf6ydYpA7KTgOP8kUtHp+a/0v4
 vBpg56Qa6WAEJ6/z+R3+YU3I/8yNma4SBm21EE37O9CjTj4LqZPjNA==
X-Received: by 2002:a05:6402:304c:b0:6a5:f202:c1c7 with SMTP id
 4fb4d7f45d1cf-6aac8f4071emr8187975a12.8.1790615584082; Mon, 28 Sep 2026
 10:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260903-ccaione-upstream-ebbr-v3-0-016658d0b6ba@baylibre.com>
 <20260903-ccaione-upstream-ebbr-v3-5-016658d0b6ba@baylibre.com>
In-Reply-To: <20260903-ccaione-upstream-ebbr-v3-5-016658d0b6ba@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 11:12:43 -0600
X-Gm-Features: AclHuK9_MoInINiv5IxJGFD_dVJ6I3BR27Yf6pLEELKYAUphrCCliV3-oxfauXY
Message-ID: <CAFLszTgz_3pyAwoqhW29hpP3=hHUpQ02o=ndeVbuSTtzBa2_zg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] test: boot: add firmware-FDT source tests
To: ccaione@baylibre.com
Cc: u-boot@lists.u-boot-project.org, Ahmad Fatoum <a.fatoum@barebox.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Johan Jonker <jbx6244@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Randolph Sapp <rs@ti.com>,
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>, 
 Peter Robinson <pbrobinson@gmail.com>
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

Hi Carlo,

On 2026-09-03T13:09:47, Carlo Caione <ccaione@baylibre.com> wrote:
> test: boot: add firmware-FDT source tests
>
> Add sandbox coverage for firmware_fdt_load(). The Python fixture creates
> mmc11.img in persistent_data_dir with A/B firmware partitions. Its first
> FAT partition carries five FITs covering base-plus-overlay assembly,
> compatible best-match, external-data rejection and corrupt base or
> overlay hashes.
>
> Construct the complete MMC provider and firmware-FDT source topology in
> each flat-tree test, including the provider phandle and source driver.
> Nothing is added to the shared sandbox control devicetree, and the
> sandbox test framework restores its FDT snapshot even when an assertion
> fails.
>
> Cover default and explicit configuration selection, compatible
> best-match, cached-result reuse and selector invalidation, assembled-FDT
> ownership, staging and its returned filename. Cover fail-closed handling
> for corrupt images, configuration chaining, a missing FIT, configuration
> or partition, multiple source devices, an invalid source phandle,
> external data and mismatched partition selectors. Verify that only a
> [...]
>
> configs/sandbox_defconfig |   1 +
>  test/boot/Makefile        |   1 +
>  test/boot/firmware_fdt.c  | 498 ++++++++++++++++++++++++++++++++++++++++++++++
>  test/py/tests/test_ut.py  | 183 +++++++++++++++++
>  4 files changed, 683 insertions(+)

> diff --git a/test/boot/firmware_fdt.c b/test/boot/firmware_fdt.c
> @@ -0,0 +1,498 @@
> +     ut_assertok(os_persistent_file(fname, sizeof(fname), "mmc11.img"));
> +     root = oftree_root(oftree_default());
> +     ut_assertok(ofnode_add_subnode(root, "mmc11", &mmc));

This clashes with the BLS series which landed in -next after your base
commit: test.dts now has a (disabled) /mmc11 node and
setup_bls_prefix_image() writes mmc11.img in persistent_data_dir. On
the current tree ofnode_add_subnode() returns -EEXIST here, and even
if it didn't, setup_bls_prefix_image() runs after
setup_firmware_fdt_image() in test_ut_dm_init_bootstd() and overwrites
the image with the ext4 BLS disk. Please can you move to mmc12 (node
name, image and 'mmc_dev') for v4, and perhaps add the node to
test.dts with status 'disabled' like mmc10/mmc11 so the number is
reserved?

> diff --git a/test/boot/firmware_fdt.c b/test/boot/firmware_fdt.c
> @@ -0,0 +1,498 @@
> +/* Clear the environment values used by the tests */
> +static int fwfdt_clear_env(struct unit_test_state *uts)
> +{
> +     env_set("fw_fdt_part", NULL);
> +     env_set("fw_fdt_config", NULL);

This only runs when the test reaches its end. If, say,
firmware_fdt_test_select() fails an assertion, fw_fdt_config stays set
to conf-base and every later test in the file gets a different
configuration from the one it expects, which makes the failure hard to
diagnose. Since the FDT snapshot is restored automatically but the
environment is not, I think it is better to clear both variables at
the start (e.g. in fwfdt_configure()).

> diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
> @@ -698,6 +698,188 @@ def setup_rauc_image(ubman):
> +    # GPT with two same-type firmware partitions; the FAT goes in partition 1

The image creates an A/B layout but only partition 1 has a filesystem,
so fw_fdt_part is only ever exercised with a non-existent partition
('9'). Since the A/B override is the main reason that variable exists,
it would be good to put a second FAT in partition 2 (perhaps with a
base DTB carrying a distinguishing property) and check that
fw_fdt_part=2 selects it, and that 1 gives the same result as the
default. A non-numeric selector returning -EINVAL from the dectoul()
check would be worth covering too.

Regards,
Simon
