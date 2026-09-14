Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B41C88E77
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 23:16:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED1EA4054A;
	Mon, 14 Sep 2026 23:16:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D-KKTLmd_zvp; Mon, 14 Sep 2026 23:16:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 20CCC4054B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789427777;
	b=JwuK4YwDswpUJ5gXrCIV75Ksek1Vb/iGJ9rsqFFRMGbQ8R9ess2NPSW77XXtvV1QFPC3
	 GG6j8y5oqaGinbSZoA//QyrvaMbIyxd5zXIQrMNNk6euw12Dc//uZjKqmSCxc81oHVdCU
	 XS2jRzfO3mZsVSP8K8fG042KnRxhbJaxeLsANLJ33HTwpoV6+LiRxx5xZ4Xi1I+ZMkCm7
	 YJvD7rnCdik8ttjU48jbipy6wawih+dNhQQTGaO+/RpSuDziGFT1w709dFLhL8Uy+LfHt
	 7R9DLEXiLXS4nUIKbklt8oMN80xeFv0yo7nT3Ba4FieykIVoMeVVAk4Urxgrls30hYA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789427777;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=QahgOob8SA7a1s3lpoL6k5iGfSUH6kXdkAXJxPplLb0=;
	b=tJVnahenbH4s1NY02QivVxSFBjZh6elVNlCDQnDD+vsaepvi/RiMHtqKiogA2ABludGR
	 HwvuZhxkLKQE34PjcqpT/EH9CxCln1FOIcXtZNoOvfLFYMmVHv8XEcphjY+UMjzAAuQK2
	 ExkGvCavo7fdCDa+rDD7Gc0lPfm/Yei/KWoEsJqJUq7mlh/yBlcCN+zUYny2FRidIy/ub
	 30V++DRXFPIyAP11Bp5YwQlaCy2BpoNhOeoYfOI/K0w4906vgql9N0bm6au060bTnEve6
	 EXzdtwFdeKpMXnrhjF9MrpaQH9RqzztUhc4Aari7LyazNK10FyaLFufRCDsBftq/5cg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789427777;
	bh=QahgOob8SA7a1s3lpoL6k5iGfSUH6kXdkAXJxPplLb0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aQqlKhG2Ze+3ESjJ8uk4yv0lfYJqU2NjGRv9PyS41fAKineMR8C63NyCTBrzX9Lg2
	 bmj1eSq4rqg9xbmXJyhBmDO42nveQB6m/kbcmJdbVL12kyz9s1WURQOFRXJFrwK1wg
	 AApdwqai3aMbf4dEL0954GUCwVzbg2BYmFQRJxNjYcR3K7WM1qIA7uRAs+7AE6zURT
	 Mw40GIEljAcao2APTG8zEWX7SiQ3OFnxw+gUtos41oFKyD8ihOh9OoNoJPqGaUClBU
	 OhrkdWchLd72JgPShCO22pPJOG8Zaq4vxX2f87byU6kRJ4J/FrV4uXj/lIAQr8MI0s
	 3NBdMMtG5FbtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 20CCC4054B;
	Mon, 14 Sep 2026 23:16:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DF636259
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 23:16:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C59C880BFE
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 23:16:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5cTM6Dc7v1BG for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 23:16:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 068FE80BDD
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789427773;
 b=ULI60nU/wfohn9fznETLuPx1SE5YLc0Iv1oy7tYx5R8ylB1NqLu6jyZpn86RuHNu31bP
 mZHhWQwpfhKs42NRfD+v5XlGoUH2kXrtL6BfLHkhQ/g4dq23HUWoYQe5jERi826aP8q7r
 ejRyCTAPLv10I63u5VNBeS+Gp1DV8My4jGSdi9icmHCV+d9VwCtCt/QwRM7YF/dZM7brm
 VMarmJTt99LsYrwh4Rw3TzVA7eXSproVQvjBFgNJBRdIWvtHmKHpj1XXaZ/yHgwXdjByL
 drWVLRdisArzJMRROc1PVUXhhGvEt4GyZdyx3dmcbT3lVtHNCsT4TdUHgbNL6Cy/YUg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789427773;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=QahgOob8SA7a1s3lpoL6k5iGfSUH6kXdkAXJxPplLb0=;
 b=F9SkuCShgowQVaI7tX0qwCIkRB0jkxsipu0st3V4ZYhyJRauG6dBuvip73QKDPA3GaKX
 c8ZSl9+CyW5rCIxjPuGt5/D8fMdIi2Vd1sFp4MREVdhMtZfw3+mKdrLy5Klc+KtRY2Nl2
 2LxxgvlqyjSPKxusjvpokTswGW8Ywgw3Ryker2Bobzs6IYsdhJNJIEadimqXjX1PdaqS4
 +L9W23kGZVRDw0LODp5fKyxCBQWpubF8NAhcZOic7Gw7lsTIpARQ1tfrj0t7ESpLGTTn3
 cf82/FWh/LjaWCxh5vqkZKB3IZMcZ4A9x5TkJHJW8N+QBE8cUredIZJSk5PNNSGzIMw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=pnyjjHvo; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::11; helo=mail-oi2-x11.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=pnyjjHvo
Received: from mail-oi2-x11.google.com (mail-oi2-x11.google.com
 [IPv6:2607:f8b0:4864:32::11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 068FE80BDD
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 23:16:12 +0000 (UTC)
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4bb359e6878so930277b6e.0
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 16:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789427771; x=1790032571;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QahgOob8SA7a1s3lpoL6k5iGfSUH6kXdkAXJxPplLb0=;
 b=pnyjjHvo1qyJ2tx8bc1uMZypzbt8+OQlVPxhPrwrDxwu5hflD2PNgQpd9MPMaskiq1
 Uc3Ptiem1yWwfQBGWiXUHN1jVYptLOBA7MuXmQaYvRm5NG0qHVQ1tZX6hJJ97kVSUhrS
 yviof+dyJRTacYGeo50GbEBi7SgbPOrWlJNSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789427771; x=1790032571;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QahgOob8SA7a1s3lpoL6k5iGfSUH6kXdkAXJxPplLb0=;
 b=VUnz+qCIodWsRQiKs2SjwRQybUYI83f2xwCVA4yZeCWnlC1depBYGHd6HkdvPMYBMo
 oOEVsBJMmdqxO1edcKAcWPpxcAcIJ4zbX0jroYiZIkvlEQb+P+L/Wgmp2/vP5sKm7XFo
 LQnrD10Zw3v0ZhaDR11WUs4FQSlt5IeRsF4CNhY5PXHhTR/HLKCyGK5bt3bWy6V9pKnx
 1QhCQz9oMUg5kslZ0ryzAbDlTmXGcuT9SLZYWMzIdGnCLa+kzDL6YR3DJi5MU74z6P4g
 9qwnQoWUA2IfvQHjjiz26c3KwG+HQoTpwdaswMASOiTXNQD2456J9E+exw7c63lYXzgb
 llBQ==
X-Gm-Message-State: AFuF++kJD0YvieePiq+uQ8cZ2PhehnKJ2VxloKDvtnhWL5PQTFwyAwVh
 wWOrJIjytZLAlcHhkGlqsQu8EHCU66aEbaIKxu8BCgFC5X5VOCoe6Noqvjq0iM0pIVo=
X-Gm-Gg: AYBFou3kJedBtIVYX24jDvAKhJHGB1kTxZga7iiiscIWPYZzgJvYnv6NJ/JVgHCBao6
 tVwAgNJsGY6R+u+P4oiicKpLLq3j+qYbx7vFlFOCvfylaeQesenIae34AYfDezogBwJ9Oe9lruf
 sbHa40thneDUkbM6ge6UmjMLJKeGzzhbcd1m7BF5lI9v+w9Si1mcCx/Y0zGpQn2Rq/c8W2IwLbw
 1OgD7gXjIE3zxXmTUMaIPyr4rhO/5QztiFeI4ANZLQX3lQc7lBbziBZ0ITDSK3+RDmsLhxmB4fd
 3usZFo3FD0N9wJARU9dVTWCLM+zPhkm0kclKIVYMWB3owMEwftwaOhru8SvkO4g6/eWfJEwcMGB
 IeMq9+s0TTphYA9TeC6tpJ8YiT3TmG2FMbA6er+UiK0DzwdLTSknrmg8youzjrKv2ZjN5UiDTBi
 A5r2h3odTaotDuatuwg7PI3hCD0DuN39hgsapQrurlxQUGABWV8KvfzzbVOIgpBb7pOVqufuiQy
 l124XhKjylqqmiAWpix5xIZDKSMAW/0aJVdA8FqMDkC9WROUbFUawUHIJyYaWRjRqF70Us+6wU0
 q3h1h7jl+ragmfWOTXsT
X-Received: by 2002:a05:6808:f08:b0:4b9:a88b:8895 with SMTP id
 5614622812f47-4c7b6272fcfmr3924972b6e.43.1789427771414; 
 Mon, 14 Sep 2026 16:16:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c3314b17d0sm11811299b6e.8.2026.09.14.16.16.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 16:16:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Alexey Charkov <alchark@flipper.net>
Cc: Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>, Denis Mukhin <dmukhin@ford.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260826-bls-v2-0-17df3c9548ba@flipper.net>
References: <20260826-bls-v2-0-17df3c9548ba@flipper.net>
Subject: Re: [PATCH v2 00/13] pxe_utils: small fixups, implement BLS type 1
 boot on top of them
Message-Id: <178942776980.665895.1810947658170398618.b4-ty@konsulko.com>
Date: Mon, 14 Sep 2026 17:16:09 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 26 Aug 2026 20:33:52 +0400, Alexey Charkov wrote:

> Add support for the Boot Loader Specification (BLS) type 1 boot entries,
> as generated by default by systemd's kernel-install when loader=bls.
> 
> Given that the format of BLS entries is pretty much the same as PXElinux,
> reuse the existing library for the parsing logic.
> 
> BLS type 2 entries are out of scope, as they are effectively just EFI
> applications and should be booted as such.
> 
> [...]

Applied to u-boot/next, thanks!

[01/13] pxe_utils: fix W=1 kernel-doc warnings
        commit: 42f268c89f8d5a23a0e0748693ab0cfe0e9a18f4
[02/13] pxe_utils: accept "options" as synonym for "append"
        commit: 7c38bac6abf4e1b2fc3ad05e067c0090288958ab
[03/13] pxe_utils: harden the "append" parser against malformed input
        commit: 5f80d8614ca2a6c71476864aee5647e66fa462e6
[04/13] pxe_utils: extract per-entry key parsing into parse_label_keys()
        commit: bb7b839e71470dbfc4219e99e8fd493c4f73a6ad
[05/13] pxe_utils: export per-entry label helpers
        commit: eb38123ead89f38f85e68bdefa5f5aa2bc925bfd
[06/13] pxe_utils: optionally ignore unknown keys in parse_label_keys()
        commit: 98fdc9b502330eaeb60964bbf5c18024b2147b87
[07/13] pxe_utils: accept "title" inside a label as a synonym for "menu label"
        commit: df3f0a81e91ed6775232291592fac232b939a75f
[08/13] bootmeth: share the pxelinux getfile helper
        commit: bb3beb6c802a0d0a57bc586a9e9f14c780467820
[09/13] boot: add a minimal bootmeth for the Boot Loader Specification
        commit: 17756b69064c4ccfa254becd7e52148e7d583bab
[10/13] test: bootstd: add a BLS entry to the Fedora fixture image
        commit: b8b69a660231eefdbd79e04fb6940e2d13b58797
[11/13] sandbox: enable BLS boot method
        commit: f1ca59e930171e6bd28ffa7e48fc29c0344c1a00
[12/13] test: bootstd: cover BLS entries below a prefix
        commit: 8aa74cad35f8964287d572f77a16ba1603b143e5
[13/13] doc: bootstd: describe the BLS bootmeth
        commit: 4d2d6d080620a2e5114991b8de3386ecbee0a5a3
-- 
Tom


