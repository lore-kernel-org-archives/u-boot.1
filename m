Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B77C79FA0
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 16:28:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5E1D140595;
	Mon,  7 Sep 2026 16:28:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jOjfqHrIL0hW; Mon,  7 Sep 2026 16:28:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7941E40566
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788798489;
	b=O2KfUgAZ//WKaEubHgf4Ou2aIO+EQULqYb0ynTSU7VRUNyAw6pkhvmFBfRNNEHWmNbem
	 56UCm6jBvh6hOcQ1Ksu0mMYBR40KaERQ3lEAbSL06cGhNMhHwWdlHmluSgb6O4R91bs0c
	 6q3tckWpdw12GTyTb02g9nxI7y98d7UF7+VJg6aHIkT9YKBud8SZ7skQqZvNNiVPS54Bh
	 FPiO/tFNAXARqIwiEDBUAEvlugC6dsQEnnDWtY1J1JrUTRuW6lYe5pI6YmfaSkkQTxOc2
	 LVIUWVpUbSRSUatUdBOQojgdRxYu7+5o2gUsV/1iSQtwtgIi1bo+F3gFHmrdtnLj9bg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788798489;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wocnVF92uXGsSTPD29CGI8731djW8jl9gVJCwa8vEP8=;
	b=pIeZObjcVD+8lJxUxiNOy9Dw/eTn2o8E74t12hiOEHPbfk4TVysD6AMemAQACyLW5r1q
	 iGOOYOxrEzSqNKNioLhj7+/QcSML5C4lnc9Bm+dhl6IZ8ER4+rqJVWWOJWmDCk9DGRuZ6
	 vNTRVf2//Ltrg7ui03uuzS5qtVYcQaUQRHLlPpEf456jCj7HizqbhLS8RHs/EpfzuVGpo
	 VXGcj1NUzEWuR4bPJOncmQ7J6FQxuL0NmZChTHdWfggeQncgvap/VKizqO5kC+mrmst6c
	 HmZN1d15gwtM2TPu46DvSH2EjktDyV8KG5RXzt9S34soz5fbWqsQS8vZPNChwjWZB6w==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=riscstar.com;
	dkim=pass header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=wJAFr+vr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788798489;
	bh=wocnVF92uXGsSTPD29CGI8731djW8jl9gVJCwa8vEP8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XrnVaa6JtcSMiHst+gNN3y9Iv5GtybnJZpXWdqGn36krTpRblUBzHqJXZdLBGf1k4
	 XIgS1ahQPA+CUMhBgIj2IudQEyFzhR+fjvXRZtC21pth3PJvE7OPfpZp8lq3wLx4ub
	 Wd60AmGl33HruKYA6LZHKiXXuyyB4VPk8JNXAGVMgkHU8m+xWF4+U58CjsGNDTqIcW
	 X9KM0NYBeIpPhT+U1ID3uStziPOpLWTQwjU8V1sghZrzGupZwBU21UVKSxsIHyOlwc
	 7YVdrLcHxXa+gXo2q52tmDX4vgf3q7Ll0/BCw3i0UAsqqb2jnVd57b0UmDuSbsEF7n
	 tY7VD8l+r2bew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7941E40566;
	Mon,  7 Sep 2026 16:28:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C08F99CF
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 16:28:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A73AD4057B
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 16:28:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cEvaw9FzHn9P for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 16:28:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C990C4055E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::129"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788798486;
 b=rv5BU5nH2q84x7o+RkRtX200u8qwp0Wr6vGs6GHwgWs7xVdM/CX8NgC68oAQdxumx1P4
 yjFW5NoT8jwH20Oz91ExiXRJREzkgz7RX9l+UN82itdUKzYHeqbY94KPud6rvEUApHvXf
 kfPKC/Vws4fToY5xm/wffMdFOVBYKDZCDp6XLzKghwDObRWjrNdItRp0QZtM1er8dnbf6
 MXc8vHX23YgrqQbuOGJbjagWA4JXtkTA2bXLXifrZ49p2kNERJxnytDn5blR/V1ujEOvh
 qKdqjpkYhbJQKHv5dipz8TjtLguCRq8ETcNlx2aAqsOuiQwnTE1PBeraiLRap1DKejg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788798486;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=wocnVF92uXGsSTPD29CGI8731djW8jl9gVJCwa8vEP8=;
 b=npN6rbJpmZ1+IIooX8RPqYgrd5tjWJKI0Eu6l94CFJJ7zOzQ7ULkDZ/Sl0sGJTit2OpI
 E/+bNvs9RBSQaEpfyU1SYCRCxy+R7G38NEGP1ILbIX0DuPn7WzTuO3o+SKhd3hYmPc5Sm
 v12nT1Gm5QR8apUmW7coUQksUA2gCxFMkznL9APyX0Oszaxosd/TN8T69asFHjRBnfcCx
 oiWJi864SUmM6NHNcPMQqS9R2G02xQQ5ZfJe+0zqpi6OCoPcTUQLJIIUbERIfcrUDbL3P
 I6Z3B1iqtwKZkrh5rbov8SMvwvhVrWg7353OWX/Nt+c0bSZn6mwnTgHSD49SH6vqi0Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=wJAFr+vr; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::129"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::129; helo=mail-lf1-x129.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=wJAFr+vr
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C990C4055E
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 16:28:05 +0000 (UTC)
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5aec201b582so1700699e87.1
 for <u-boot@lists.u-boot-project.org>; Mon, 07 Sep 2026 09:28:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788798483; cv=none;
 d=google.com; s=arc-20260327;
 b=oQYsrboMKmDI7OUwPuwqaUG0u6kR6adS8Ir4H/un9djCpkS+4D6peHYrfgPOygca4b
 F5rluIaCBSdbH4VhpcyTKmlfJiL5+IEV8DXHPEdt8MekSCXfc67Beaekebly04QvZeUu
 WBGUnIVXmTpHzhPA1EGThH2Uf5iT0dmbPcP16VyfKiOMJ1MHiFHXWtfmX2KGxyOKzKb/
 bQZg39ZxBvKxnna8MwNuDD0v9dxFQWFr1o4HX8SOl3nE3dNWU7UHKzegYagTjyY2RLZe
 ExHu+l82+N5LltMAlc6msWhjpOp46ZX0OqqVHIYfCAceTeZ7q/1xFkt4lZBzwWdTNSQt
 nE4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wocnVF92uXGsSTPD29CGI8731djW8jl9gVJCwa8vEP8=;
 fh=7ZNphACAs8AkTSbo90brO5QyRvrGl+Bpj0Hju7PSJto=;
 b=PVTPjBeQ+Kt80J2LJlDTmICG+eNkb4lO6Nz3ntjpM06d+527dPNi43JD20YEiv0Re9
 QgjodXqKMwtoKlBC6L4J43ygIhz7vwp1s1850jFigwGquM0f5kAdbq6hWayTZVJKg5BA
 f4SqPfwQGLC6UDX/ZvJ0Kq5F6ZSxnBpc0/jo4dfVVGORYsZDt6EoGrho3F1U1vSCMtU4
 LUPevtsY+GBiXkB8w52zI39/vBQe/PSaUbQe4VF1f4dmw34mn9ybLqxH6LVOgGz0WAGc
 uJFshc5i7mIlIumGlhJlxAgGaD4YuirfF84WUeCY7p3KbxAJpcMlGMm0psot4hNM0Z9u
 yttQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788798483; x=1789403283;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wocnVF92uXGsSTPD29CGI8731djW8jl9gVJCwa8vEP8=;
 b=wJAFr+vrKJ7TQMXgFnfi0NlpBiNe5zMwRmwsmtfYOEyf/9aCv/DAGS6KYQGwQa7zCP
 IE4sQRuuavgU7TuMp7VuhYo0ikW7+onJPUErcZSnlUozDpwjCQPnyOWqWisEaHV2JLXL
 9LQbVvfla27iTipDpP2FWHhLYUZso5t1r9WXkuBe4GzHNsj8sK8AznZIvw5RqbY6A8TO
 xsxlGigJPVAa0JqcSEeLjnuq5axg2ewN6lPB/jDai+i94GratQbdaXWL1dJ/Y8xfDmci
 cN9gU+5qpNEq1RDjDsfpCYJsgJNyIfSCy+y7J/HHMptDZPOTndFWkOmF6b0siVXssD6z
 BN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788798483; x=1789403283;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wocnVF92uXGsSTPD29CGI8731djW8jl9gVJCwa8vEP8=;
 b=e5JhWmgeZTYHei+dxUbZIibt74zilx49RVylufzz8Xypd/5MPUolzqRyYX391q3Xza
 pE6NtD1c+HTw3KNAg8oVmtRf9DXzq+W1kq/CHM2iW1V2SidR53SCrHLtsb3aR1cVDB4O
 9wdnw06CqybQ5CiKjWBc+eznqS76/wrb1hh638jJtJbHNFyG+w7VDYXXNM8AzQsSnpCM
 zlhsPn6qLs8KdwgxHL/enSRcEroSy6b0p+jOm1VrnJfUF2YR43RojIfpTqdS4vLnnn9s
 lJ7GUAtk0OZsw+UbBhO+Ketz8o35HN/68e/NybFQ7ZRGJ0iWOLGLQ/Qr/UB52HC/B82Y
 fG0g==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2OZLRz+jCJU934+snAWXveYWMg2mjjJjQRPGwdTeMlnRfzte8KVyJAcAzOHRCQuP+B1lOtp8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nkfK5Lz3TxdAXTYAXhkG/woXJSN7/5HZw8mj/BwWZGFo+5Zh6i
 NPaiRZUhJQxOoXnV2aRzI+ntyutgOtXPK8aF72oYHsvt3ADVaGBdGJpnQZ68D89IGKb46DSGYG6
 SqSrte87wyysU3oMpOfcMKbOyWKlMYiwYiU41wdn4Pg==
X-Gm-Gg: AYBFou2ga76E+3E8o6mdUrjS5OKhWS+hMqT+eSk+0Qdcwa+XitRb2BotFcYerR5Y3rm
 4xqSPwS95RBCmeMHuzL7YXJVmO9mx/haIP/KEkkwOoUXHy2WE2dn4e6zvAbLWATmPr0rodROCAF
 DcgZ3jjQ0fzH207g1r0DBfatYfMSHi+Zxe1N/v6w3OskFnkTTqySASAzRD8KL/WIYME1VdHPwYw
 htZJtzxPqfZtYJi5mkHDHKtf7mhHnRWWrYwXzFlwnpzLAK3icMyLzAd4qut0UFPJNV44xCKiY93
 ixZHjJrCny74oUfm5smF13VJNWzy7h/ifdVVuSnGjMvQjZM6Pc83VyomlXk/0zWlT8q5SzhagzI
 pcHArPXhduodd4fMB1CVX1TZaJnOpeREuyM3SKWsxp7CAF0Qk8F67tFVWokwJHA6W74fQ/YiWPq
 IdCQ==
X-Received: by 2002:a05:6512:108e:b0:5b4:a9e1:b8a4 with SMTP id
 2adb3069b0e04-5b616f4a238mr3836737e87.25.1788798482319; Mon, 07 Sep 2026
 09:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260906-m4-v12-0-89eb5a8f879d@riscstar.com>
 <20260906-m4-v12-2-89eb5a8f879d@riscstar.com>
 <ap52h-_UQz15JRVU@pie>
In-Reply-To: <ap52h-_UQz15JRVU@pie>
From: Eric Chung <eric.chung@riscstar.com>
Date: Tue, 8 Sep 2026 00:27:50 +0800
X-Gm-Features: AcwNN1WjE5HvM10bAZ6M9dm6GuwqeC8c_SBOW0RznUMKdGo-B0iESWuGJwUtj6I
Message-ID: <CAH22mJxMXA0gcBUJrqMGymWn-BjrnEOBd-t5rUjnwakrMaZkYw@mail.gmail.com>
Subject: Re: [PATCH v12 2/7] mmc: k1: add sdhci platform driver
To: Yao Zi <me@ziyao.cc>
Cc: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Wei Fu <wefu@redhat.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Guodong Xu <guodong@riscstar.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Iker Pedrosa <ikerpedrosam@gmail.com>, Alex Elder <elder@riscstar.com>, 
 Andre Heider <a.heider@gmail.com>, Trevor Gamblin <tgamblin@baylibre.com>
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

On Mon, Sep 7, 2026 at 4:33=E2=80=AFPM Yao Zi <me@ziyao.cc> wrote:
>
> On Sun, Sep 06, 2026 at 05:11:04PM +0800, Eric Chung wrote:
> > Add SDHCI platform driver support for SpacemiT K1 SoC. This driver
> > implements the necessary platform-specific operations for the SDHCI
> > controller, enabling MMC/SD card functionality on K1-based platforms.
> >
> > Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> >
> > ---
> > v9:
> > - Disable CMD18 (multiple-block read) for SD cards in SPL.
> > v6:
> > - Remove ".data =3D 0" in spacemit_sdhci_ids[].
> > v5:
> > - Remove MMC_CAP_CMD23 as the CMD23 support is now a separate series.
> > - Use tabs for macro definition alignment.
> > - Use read_poll_timeout().
> > - Set pinctrl state based on selected timing mode.
> > - Add the definition of SDHC_DLL_REG1_HS400_VAL.
> > - Remove the condition based on quirks.
> > v4:
> > - Add bulk release operations on reset and clock.
> > v3:
> > - Enable CMD23 in capability.
> > v2:
> > - Enable ADMA mode support.
> > - Use CMD23 for multi-block read/write.
> > - Move ASR/AIB register into pinctrl driver.
> > - Correct pinctrl state from "fast" to "uhs".
> > - Migrate tuning support from the spacemit linux driver.
> > ---
> >  drivers/mmc/Kconfig          |   7 +
> >  drivers/mmc/Makefile         |   1 +
> >  drivers/mmc/spacemit_sdhci.c | 684 +++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 692 insertions(+)
>
> ...
>
> > diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.=
c
> > new file mode 100644
> > index 000000000000..4731c9ca0832
> > --- /dev/null
> > +++ b/drivers/mmc/spacemit_sdhci.c
> > @@ -0,0 +1,684 @@
>
> ...
>
> > +#define SPACEMIT_RX_DLINE_REG                9
>
> There's an on-going series containing fixes for SpacemiT MMC controllers
> in Linux upstream, and I noticed this patch carries same issues for the
> delay granularity[1] and minimum RX tuning window[2]. Should it be fixed?
>
> ...
>
> > +static int spacemit_sdhci_execute_tuning(struct mmc *mmc, u8 opcode)
> > +{
>
> ...
>
> > +     if (max_pass_len < 3) {
> > +             log_err("Tuning failed: no stable window found\n");
> > +             return -EIO;
> > +     }
>
> and here.
>
> Best regards,
> Yao Zi
>
> [1]: https://lore.kernel.org/spacemit/20260902-07-k3-sdhci-fix-v1-5-b15c5=
d0f64fd@kernel.org/
> [2]: https://lore.kernel.org/spacemit/20260902-07-k3-sdhci-fix-v1-6-b15c5=
d0f64fd@kernel.org/

OK. I'll include them.
