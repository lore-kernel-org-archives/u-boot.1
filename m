Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C37F7CA5FD2
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 16:01:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B15F60B26;
	Thu,  1 Oct 2026 16:01:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KFOLX0HGU-1D; Thu,  1 Oct 2026 16:01:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B2EDA6080A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790870498;
	b=jCfxna6y9tRYwN/VdnICuMs7A6whDTdblE67ynIRKQzAevrScRAS5vZDTZW3r/iSYh7V
	 T/TzVZml+h/FFv9dAd377QN2v1VDDJerpt1Gf04x1oq9BKLttR7QoiVorB9BlToXpuzQL
	 noxNUfLV1BEiUaBJWfB+sQ7Qs78Df35mgvmkyH/UYe8TRMGpAazqftZIwTSrdPPdb0ojZ
	 ytok0rmCtX785jZgC/XK9BU3cwvXzSehehIHdRoh+14Imz6unimGjjzo5Y5TLHxKcMxW3
	 gNDivYbRwycs3uh+/MCuP4M08Eyi4a7UsnddtZo0agHsZM6U/KioIl0bN/dVAZNLfKA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790870498;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=gDaLqW1yyTrLPGj5i7etQz/t4EsqgQvo92jvRC4uHiQ=;
	b=XJracZK6uzHRLT2m24EEih2egme6IEjbi40MdccjKfchG36I7VBDPPO8nfl8liXAOayy
	 FfcSGGLNSGvALrS1gFHFSpfyxT/lB+SALhbUW3YCBT5yFusa/0N6fIHozLnxpkpu/LqUD
	 0Wb3bQOt0eVPNXqmIIWgJKhpA675ATIdFC1E5WhAPzGMvwVjsMY3dZzvGy6nISAMOD7Ev
	 lCLvb0tzJ/VzrujYGWrvk/kVZZobWWN1k248CUI+AUp4W7hZlNk00y8hIxdug1lwJaDK+
	 cJ5SqgPgUVoRvR3V7CaK2fyU3BxRmadfmzUOgTR6D1SAP+0b8+tDsX2IwRhP8P5usnw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790870498;
	bh=gDaLqW1yyTrLPGj5i7etQz/t4EsqgQvo92jvRC4uHiQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1PJfreJgBm/uRw8Ntc7ZpuzgNKYfZYSFNihk4qpbAkMIq4+470W33lfyitgYajO9k
	 Q20VvY6s/wD+409JxwNd9RM6UrCjOKtX869H7zlFZYEFNGsyEOmZDMeg+aJhTUYlf0
	 g7Jq12gMmhJkfuqqTl7hJSCcjbbIEiaQWW6jD0KOlFqgWljkGY3s2CwnkIVoYe+dTW
	 BXYDVor7Xkm41FxFVSBSlmWHVlo27EldHmA49fKwf72aL678rQlViapgE13Qw9XGX8
	 tcYo8a/ZQbSeYPq5kbyz02l56s3l+0UUv5iJfszvXCY/lofn7ZKlRPRA+3mv35QAT+
	 UMhEpV9KPYlFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B2EDA6080A;
	Thu,  1 Oct 2026 16:01:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A13B233B
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:01:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9EDD740CBF
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:01:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tkqhR4drfTiR for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 16:01:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9FFB640CB0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::2b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790870497;
 b=ce0Fu8QqsqJvVFo/cPd/JXEqdkxgvtfbZipT8vZBTO/5LspUSHdiO5CzWaf3fyRtnCSk
 Ohz+lwYwu8Ux5UkW/twOvZU8tW6oRfCqF0t8rZQcea0H4EIoV2ikzrb+NUNPtelJ3J8qZ
 lKaHNymIkWO4WvAeWMleMAT7gpnwuProFT2pLjLyDBj5UGgT9Hp9UbbSQEfTFLw3y1Fzr
 Taq0qUjnr9N6OAfPSG5dIeFiE1vBomNAX/Llr39Y8P26l4JGcIE1MSGmALMJ5YXaOg6SM
 v2UUyF0hmKTjLotWS/ftcPNqk1qIwXxEsSVUYypypR2f5r7xYvhlm8sIpXiveICXzSQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790870497;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=gDaLqW1yyTrLPGj5i7etQz/t4EsqgQvo92jvRC4uHiQ=;
 b=cpy/3bAkbgzhoZIqIUKCvT7LWToRyNwxT+aKoO9J5YUqf+d3hn9kDfVTV5GRiJmeRF9n
 /S5i1SXv29Waf35GWA8fzDLiK86AL4cjcv6K4wbGbzPxRgctX2ltvPalP5xQpPD/tUrQp
 K5Hp2ep1WQqrNTPGZ4BbaPtZqwMT3uKlbOsyEqr1Xv6fz1hrML98V0BML2ss85gBJezTr
 NVHLE1FooY0T6KlAJZIMyeLlKMm1rGjiQUHKJEfsARTGkENQVz7lW9TyMxOJVZ2XCjZbT
 tH9p8BQXrpUs7FPPovKqfxajKOiefqR8VZnE2M/Ach3t7pPIp4nPPgw0VPZrc+P1H0Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=P4ObRFP7; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::2b; helo=mail-ed2-x2b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=P4ObRFP7
Received: from mail-ed2-x2b.google.com (mail-ed2-x2b.google.com
 [IPv6:2a00:1450:4864:33::2b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9FFB640CB0
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:01:36 +0000 (UTC)
Received: by mail-ed2-x2b.google.com with SMTP id
 4fb4d7f45d1cf-6ae3a72e02eso1707867a12.3
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 09:01:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790870494; cv=none;
 d=google.com; s=arc-20260327;
 b=UdTNM/pQ+ViWKq7k0OH2C399R22XRgt+VDAc+nvaHBbe9y789cb+b7kslHhfhF4X5U
 R+NtaPo4kNl04Wl+w/0NeaSPShvASMhXv2BTMGfVzFQbXG5D9R+KkHl4Z5hZw0A1uERR
 TQChwXaMtcO9V8YkNt2Br/eXgIaZGeLp6UUm7JTp2ZYv5CVHC9cFpXOzAq6IGJE7t9PL
 iHlMf3gwrCgENqGqBZE4F+aDjT1rmYOoO33Rlwv2LOyhF4RN+rl6iQo1xDL/cMvYfgYA
 RArzjvWJFgjR/GXcqGPRQrHQnLK3qOdUyhZM8OGlxMQoQD83DbWYFsjImehf8Pxm3wPD
 YUZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gDaLqW1yyTrLPGj5i7etQz/t4EsqgQvo92jvRC4uHiQ=;
 fh=GpLhVy5HYtbAmQbBoMAHheo+664W8P8PdFJ+aKZ43+I=;
 b=nr+K3G7dRlrEMF7dr7Z82B/irwn7EMm+YzyOLPnMkWw0pURZfsWE6m1uvi5Na7MVKF
 oiAPHEodZdXlrCzaMYc6kJ1LOnLtQTY+z9Z+bhU10BI44ggXQqnKQKaTsmF4HfULPOG8
 MjZg95OmYMHwTO3oSS93p+DTxZ7lfzE6qNS/h4zlQ8n3L7ptLpYSPGeWkpzmEaMmqoEX
 jpJejXEoMeWBrECszsmTeVyVZyGpQqFuwZRdIXfNJIkDTO9UFFg9L+Vyc44394qX4is9
 qNPClMHWZnXOicHyRIJFUiGvV0L0FkubuvQmaIWRdLiGt78W+3S6IJzKWt32oOPE+BtE
 PUeQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790870494; x=1791475294;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gDaLqW1yyTrLPGj5i7etQz/t4EsqgQvo92jvRC4uHiQ=;
 b=P4ObRFP7/ktPvzDlDSsl3IDOzhXWrO2/7BEVTznS01DJj2LDWfPDjH/OmMZkrzWJm/
 wR1YzSiEAPXYwhgE6bLZd0hfyV6uk7kCEKUNX5nGb6DuVck3r3Rx+5sqAliCQA+6f4vl
 pJgn9lKV8xvbpTM+bAo+LLVtUKSiwaeeUECZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790870494; x=1791475294;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gDaLqW1yyTrLPGj5i7etQz/t4EsqgQvo92jvRC4uHiQ=;
 b=rdTcfOP9jORozGmaaTd1+8hPV5/RcbbkRHkqb1RQ08wXoqaOnxa6UOKs6qo2qMpu+L
 iWUJSYWMTxfFU5Y/uhjXXRWWtUveP0WsHQoURTI3F5sBvs1Eemhznrhq55FcriSig8c3
 LxAZNHJqe7htHWOZ8hRhATpZRjVyYz2hQEcl8AtR7J00NGuDvqnM2jjuMK/034j82Wqc
 D2bp75uW1YgVzDZqs3EmD7R3/CvUb6d2xEuh3j3q8UsUd3uJaDEvSjdaWT3YTKDMLF2A
 G2tHkk2ZWXGP2KiOHqvTU/yfw7b0QPB2rudvVEcrvU5/xnmd5D+JA9wnswHwrQeGCjVp
 0QRQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwd1Ks0V671h+lQWTmrOlqKaeJX1KOvkVPXN1TigvYYzLgYDVyE5LXNigg0GsLF7PuGZV4NPNQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKERXatzOncCuqkmvLowFjZcvTF2yybdO7nTnA9hBw87sS0j+eM
 zeGief8ClWCOPOu/hUolLEReGYxKtLiG05+KZVo/gif7mi+ma7M6gLCtMp+nyr63JvEJFaFFOR4
 upyAGCAXb+jDMjWevaANVd7oOs+N4sGk6s+2hzzwf
X-Gm-Gg: AYBFou09uVB6Bbma7BT6ByVlck/567Ttz2jLZXW2AOCme6xHCuiMdWwGstm3UF1tM0D
 5Q0WOVam7Eea5vv8mxV84gdSpLqKa8Gl0+jB8erWf6PmB8MHKvMcTHaSAcW7bbd8bfFbJRVl3uu
 0XYX6WvGcNFwOQJ4k/h/KbqffUyquQ3y95flscZi7kAenbBNZli3dd70MrSMX71S1cNGezoXxDu
 4xfVcYS/31CtoFIdvPRHF0mBT9FxMoWOE5KW38W17OIKO2hm5LjuYeh66Ze338iTuuk/le1zsFY
 NAWE2lrffiyB97Ax5/JXBfNexFztry4s7ot5ugoF7m8jwUqmKA39wqkp
X-Received: by 2002:a05:6402:4394:b0:6aa:82f:8093 with SMTP id
 4fb4d7f45d1cf-6ae19956726mr3772679a12.37.1790870493976; Thu, 01 Oct 2026
 09:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1790626459.git.daniel@makrotopia.org>
 <8fc90665aa0d615c4fe7fdabae57727666cac612.1790626459.git.daniel@makrotopia.org>
In-Reply-To: <8fc90665aa0d615c4fe7fdabae57727666cac612.1790626459.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 17:00:40 +0100
X-Gm-Features: AclHuK-TgDxUSUroJGMOen6BTSjx2wuQERepwPqCvx8W9x6zXnVmKZGrKj6vAtA
Message-ID: <CAFLszThsD_3r7zp98ktAUxTdBa8TeNxnM-iDXs3VKGd6Wyu2fQ@mail.gmail.com>
Subject: Re: [PATCH 11/11] test: boot: imagemap: reset driver-model state
 between tests
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
> test: boot: imagemap: reset driver-model state between tests
>
> The tests bind and probe devices under dm_root() and the storage tests
> depend on real driver-model state, but none of them asks for the DM
> init and uninit the test framework provides. A test that fails before
> imagemap_cleanup() therefore leaves its bound device behind, and the next
> one trips over the name clash in device_bind_driver().
>
> Pass UTF_DM throughout, and UTF_SCAN_FDT for the two tests that walk
> device-tree partitions. Those two are also marked UTF_LIVE_TREE: they
> drive mtd_probe_devices(), which cannot parse the partitions of a master
> bound from a flat tree.

I'm not sure about this. add_mtd_partitions_of() reads the partitions
with the ofnode API (mtd_get_ofnode(), ofnode_find_subnode(),
ofnode_for_each_subnode()), so I would expect it to work with a flat
tree too. What actually fails in the flat-tree run? If the cause is
something else, such as the static old_mtdparts /
mtd_dev_list_updated() state in mtd_probe_devices() or MTD state left
over from the live-tree run, please can you describe that instead?
Otherwise UTF_LIVE_TREE just hides the problem.

>
> Fixes: 05c1fbbfa79f ("test: boot: add imagemap unit tests")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
> test/boot/imagemap.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)

> diff --git a/test/boot/imagemap.c b/test/boot/imagemap.c
> @@ -649,5 +650,6 @@ static int imagemap_test_ubiblock(struct unit_test_state *uts)
> -IMAGEMAP_TEST(imagemap_test_ubiblock, 0);
> +
> +IMAGEMAP_TEST(imagemap_test_ubiblock, UTF_DM | UTF_SCAN_FDT | UTF_LIVE_TREE);

The motivation is a test that fails part-way, but for this test UTF_DM
makes that case worse. If an assertion fails after ubi_part(), the
test returns without calling ubi_detach(), and dm_test_post_run() then
destroys every uclass. That frees the sand-nand device and its chips,
which UBI still points to, as well as the ubi_blk device.
nand_unregister() cannot delete the MTD either, since UBI holds a use
count. Without UTF_DM, the leading ubi_detach() from patch 10 would
clean up properly.

Please can you make sure every failure after ubi_part() calls
imagemap_cleanup(), free() and ubi_detach() (see my comment on patch
10), so the DM teardown never runs while UBI is still attached?
Alternatively, keep this test out of UTF_DM. What do you think?

> diff --git a/test/boot/imagemap.c b/test/boot/imagemap.c
> @@ -571,7 +571,8 @@ static int imagemap_test_mtd_blk(struct unit_test_state *uts)
> -IMAGEMAP_TEST(imagemap_test_mtd_blk, 0);
> +
> +IMAGEMAP_TEST(imagemap_test_mtd_blk, UTF_DM | UTF_SCAN_FDT | UTF_LIVE_TREE);

Regards,
Simon
