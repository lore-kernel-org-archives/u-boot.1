Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7ACBC55196
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 19:26:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 71B3B40594;
	Mon,  3 Aug 2026 19:26:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vP3LjuA4E95Z; Mon,  3 Aug 2026 19:26:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D76564050A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785785185;
	bh=AQiNkah3UHoe6dW8DSYaup60ZbJNsMB4/daonIGYfQY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nMl/HOorGmMVirn3ukOabMYEdpWgqegINH+gGAYuo/QIgSd+aYpDS2P8haSrXKr3k
	 OrUjhs4GY4JPSKzPyVplIJ9zjpl8H11W9TwGcRnzmhF/RZHjx7Xw4ll1at24OV44U/
	 5hM/Ua+K3b75T05EH7GdFHbLTOZOawijRsQKkMSFamD4+FbU7qND10eeq1CXgU//Ya
	 zZN3iUl1l9MqfFmbRwkL91dXGDgtD73wdFdWBNgl6To/RW6hDlfG1kolhhFFNZuX2S
	 9T59Z8/1lzNzfrxgHD0VY3uzmDfG29KABdk4vJV0QpDXTtSLRnYAAF90dvWVbux9+R
	 p0zenHALB75kQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D76564050A;
	Mon,  3 Aug 2026 19:26:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A112C296
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:26:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8729980B5C
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:26:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GLUUYNCpl28P for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 19:26:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9D80180B40
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9D80180B40
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9D80180B40
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:26:22 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-698a9f11776so5829474a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 12:26:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785785180; cv=none;
 d=google.com; s=arc-20260327;
 b=K1NKJkkrUEiclnv7Y30ztIvcsPObBiYopXGV95oyWnSKi1V47I2TDrEv/R6wI5qec7
 hqh5fTXk3keHa4ILXeXp3Tgy4eWCDjVitFTFscn4k6zC4UQG26muEOZOGoArZRquupOR
 kqtNkvp1M9tbDTQIEIp5/6Rh9N1cr0hcpi4Fwf8KPtDfr9/+x/TrgyHzSyCNoyp1YIOW
 LHTysx89ysfDoSdVb6bCFEGloJ4H0NR5PUtQha4gdGUCe6pmDxG7zZ68ko3pHT4SAGT5
 MQQjsY/0DWefIcuIbPlWxlEmsE1vdJOGuUDYDK5uS92aK371voysX8nkDp/0RVVrq/sN
 wBpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AQiNkah3UHoe6dW8DSYaup60ZbJNsMB4/daonIGYfQY=;
 fh=4f0P5431eIEklEsxS624FHh4PkIe3Cp2fAV7Oqy9IAM=;
 b=VKABKrAWJifZAv+0I/a8SNl6rw0pxyDTMvzHAVqsFhIOwVOEOxqGiLzCJa6384PfW7
 Kpb/Ezb7xOIkIAHxUJjf4yYU25iiwlB1UYjd5aArkk/hm+bQeA8Q9sZNbc6Mez+BfBPQ
 8hMec/ltshPeGnO7c2yI2CLrpY6OyrQP2fyhPh5Arlm+SjgxCMvgCyK6tJjwbYmnw14i
 3lcOuLXURwgs93One85WtqDQddb/NS28/OKwqZwqKq26TT70xPo+lRlqTjv9xauEhcrX
 Pm+sddI7rvCe0anx2EExoh1MNudlfEuVhzwXrzk6kMpwoUYcrW4GLVlO02w87IHjn+0q
 K+8A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785785180; x=1786389980;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AQiNkah3UHoe6dW8DSYaup60ZbJNsMB4/daonIGYfQY=;
 b=BJW1jv8LZ2LRdMISGX75xUBIdNW7RSWkAnLiQELp8JxMQsvvdmuyDR5uiNGzLz0pir
 vzehKyH0o58T2ArCx2iAstZATl6DpCRpIjP4sYfOUnguzrfvPK+aReexzi/hCKSlQEsT
 M2l2+LdOX0nLcOb4MY6fKshCCx9KIz+nS35171p09AS3QN/P05RybDv/M6kGhonC/OFy
 U/PV8V+v02isTZdlUsNpZqS3wHuB3pSln3hdpr6jQb158IeJKUyk+llvtvCGJ7yT+Zt+
 d3FV7TbBPxLLc2UdXTzmUx7+UO3geoscdEFJZVQLm2V0R1x53nKRzLieUrkLozjBhi4B
 l11A==
X-Forwarded-Encrypted: i=1;
 AHgh+RoJ0jrZjuO900Bl9PVMnOLOZvy0lHNDE7UMvQY3nuyguZ2/hkMXYdDszseeTXe+4wNKeqW3cMU=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzXE2kv5BIAO/K6EOZwqIL3Ege4oocFqpysiHAGQoj5eqBOysfi
 XpYwwMlIQUtb0dxrFh/BiBHQOPUWKi3+LcF48gqR26Xcio0JRyHDD0QWej2zG6QBa0Bn5X70trv
 KaBP+z/xGSzueCRom4k9Xcx8oF5k1/4IGNSwEKKHc
X-Gm-Gg: AR+sD13bIxHxioezdJZJHJ2i3BaVBJN6L4VTW7n7ZmaiZfrB0FsyCQpSJXDHumbeA4D
 nMswg6HhaoSc0g/6AAZ7NGcixQtjEqUHzDnykpItHUfA8HllKVOtmsckQffmZOgNZwslOQxsnrr
 HjGblr3i/QcI+s1CCwQZjizQGWQ4A46lQB+lTXXSuTf6bOWE4RnjcdadfqAH5vfnFWy3citHuWI
 ayVYOyP7ftWaYoWN2ozvFnqO4UHOuCO+4VTbkIc6yJ9Bf64mf4DrKaQV2FD/ZT7zc8FI/IA8zrS
 fDwjDo8dCN8j4iuJoCI3RKVheD5kYzIAUXxXrZ69JUhMgsd87q2UiA==
X-Received: by 2002:a17:906:f91a:b0:c1c:4752:b5fb with SMTP id
 a640c23a62f3a-c1fe7f3e45bmr747349166b.27.1785785180478; Mon, 03 Aug 2026
 12:26:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260731001347.35624-1-aristo.chen@canonical.com>
 <20260731001347.35624-4-aristo.chen@canonical.com>
In-Reply-To: <20260731001347.35624-4-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 3 Aug 2026 13:26:05 -0600
X-Gm-Features: AUfX_mxnQgM5DGsGTS0t1rL5iKBw2bsYLBbuNQDFNYKnWrNfnb5BW8hPnPH7yWA
Message-ID: <CAFLszThBfFB4Wh3f=ET9-5S0NCPvT_YjDrU-Z0-WW8=ENRjyEg@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] binman: Fix FIT image overlap issues for
 testFitSplitElf
To: Aristo Chen <aristo.chen@canonical.com>
Cc: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org, trini@konsulko.com, 
 sjg@chromium.org, nm@ti.com, bb@ti.com, n-francis@ti.com, d-gole@ti.com, 
 e@freeshell.de, jonas@kwiboo.se,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785785180; x=1786389980;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AQiNkah3UHoe6dW8DSYaup60ZbJNsMB4/daonIGYfQY=;
 b=i0HSIwjfGRYxvu/Xnu6k4a2nNr5Ev5AhkRD0+m63KIZmMZojqAJsRGYMbDOD99dtQl
 9zz6JmyyDP3zeBLifWiDBfNHdvBIVp+JQ1K31oNyFpXUNgdJgQu79f+Bgi0SUl5A3qjl
 v++YCYnwQ4jeXMm4eIePnIpRayfHheXbL6HV8=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=i0HSIwjf
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 2026-07-31T00:13:34, Aristo Chen <aristo.chen@canonical.com> wrote:
> binman: Fix FIT image overlap issues for testFitSplitElf
>
> testFitSplitElf builds both the ATF and TEE test images from the same
> elf_sections binary, so the split-elf nodes generated for the two
> images end up with identical load addresses and overlap in memory. An
> upcoming commit teaches mkimage to validate whether the memory
> regions referenced by a configuration overlap, which makes this test
> fail.
>
> Update the test to use a non-overlapping memory layout so the two
> images no longer collide:
>
> 1. Add elf_sections_tee.lds, which mirrors elf_sections.lds with the
>    section addresses shifted up by 0x100000 for the TEE image.
> 2. Build an elf_sections_tee binary from it in the test Makefile.
> 3. Update ftest.py to use the separate ELF file for the TEE component
>    in split-elf operations.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> tools/binman/ftest.py                  |  2 +-
>  tools/binman/test/Makefile             |  8 ++++++--
>  tools/binman/test/elf_sections_tee.c   |  1 +
>  tools/binman/test/elf_sections_tee.lds | 35 ++++++++++++++++++++++++++++++++++
>  4 files changed, 43 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
