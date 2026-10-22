Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ADC606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 21:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=I6B/0BMg;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=FKc1I3JY
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7C5F48142A;
	Thu, 22 Oct 2026 21:39:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7Yntly3Nv6UJ; Thu, 22 Oct 2026 21:39:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B42E78144C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792705151;
	b=pfw1j83u/7GxHEXuvAS8CYAYrJTx63/EKB+J46F8rFA25jLXw11EpSEJLxASW4nS7YiG
	 6hDplYlvR1cNG0o1wIVAcWFHxs1CGYUGyPJYQhlvu3DYQmcoYx4yZR+YsnuKpVWzUbBbs
	 cyoMr8Yea6YBgKR1EcMfCqGa5fpLPpYOCpQjnh2kwUP8XP8N0VyNtwe+h5VHYOiPtaz/A
	 tlRoDGNpNFfqWu94N3BZlNTIFwC1ofk14xEVYzgjMEDumEiFryWRdtibOWmg7S150ajKf
	 INIwMwjd/NCREuQs+1JZiB4fp18l5wA5fdaMCyd0+EEW8uwPdiEinD4LlVSMWFasalQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792705151;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=te0RaUn8FKiACGn7kS3yXSgjwS3KtO5AoPE0MAydflE=;
	b=LmX/7ro81gm53UQ3sYMqQTVbMCV8AQyNZv+yul0cjy87XJw9YkgQ8RMS8D/yyLqrujPY
	 3mB8plF1egMXrQ5q++J7Wc28ht3U0d59TBN6ei1/BEQpk0FGauMB36GaZgn394/eMTpE+
	 FiUAGJ+wB6ldZ/mfzKSYdlFRnqOmaoW71LkLzIYxxnxnqxDf2glKi5bJA+DZCDOrg4qa3
	 5HVKsjdmQXFcdTcRbbAUHvBrqU0QISMwFK3/MGhI7EtYbKAu4LF7Sci3UfSkH+l2WnKe0
	 OB1xrD3qzHVLHsFtaJ+nTIFcvej9r56vfSa5aGCR8IMkPkdcoxH3wOBH5qPgdzyfeTQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792705151;
	bh=te0RaUn8FKiACGn7kS3yXSgjwS3KtO5AoPE0MAydflE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I6B/0BMgD/fZghDcvG02DmOmc7XoAVHYqcKCfHEKJOOZdUZVQ0BceLFa8n81jv/qw
	 c7IqbTAbsq6tYqiZsafuOHGGRt9T4e1puJL+O+gW/XeZGfMtGZ7HmJY/zA+vBezGqT
	 j22dd7XSJWW5p31YxqUKBDcfKRxckRD6/ufiBtjjsxnnBr7N9lZkWQhILhrz67xEHT
	 EXT7vROXBIiGJbqKisg8y3ln3uI30uIwOO5ghyNstJFyvOzpS5JiozLPZfULPArY8J
	 xzqec22CHmpW3zSQ7HGqi1f48j36ROU4nsQfFjG1hCVb9BRargBKH0aS7Joa3m/ntB
	 aOyKjWoFMPVHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B42E78144C;
	Thu, 22 Oct 2026 21:39:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 922793A4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:39:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8F7086087B
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:39:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ECyOq5q9BpTR for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 21:39:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 42B5460873
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c29"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792705150;
 b=pc/X9PaLgXeUMbCu2TlRvIZFWLogKD8PGBIJg4+iRRgqxi1Dl2616UhxitE3y3w0urFn
 ZMB3LWWsGSv9AnTw0bGlqi1ElOCbcGTyQzgd/xDDxgs1GRGnkJxbzChF/8nBXJsdoZLOZ
 noor7qIwZ03H8OMJf5OE0gXWs4d8gti4SnpDUZmCIl28tCvl6DGYvDkeExb/L9IMlLZN9
 UZ89u7c5eK0MJr6wLu1riGGyDFjSbYbfhaqm8JOgGYOWLyU0Bphvk35cIAYX1p7MgBRpc
 60qLv7O9M3gGcMHBdlcqIUMkr6VfJm1NwBxyK+TZEiiy7Sd+R2MAnkEZus/AADSlo6A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792705150;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=te0RaUn8FKiACGn7kS3yXSgjwS3KtO5AoPE0MAydflE=;
 b=crm2lR3lqFk6YnnqN7jO/7zzCqBL7/zcy4DmCOiSL7vOSE8LRTuHZFt5HeTBBcnf+HwE
 ufIqH0UyhkDHCMgoGI+ms8rnxb7Qa7iaXJKjMLlBRSmWrh84L94iUixS8X5fBMJJQu2dh
 7mrfpO+B8I2CyDxwXJ6mhWzp9ysYWoJUYGDZ5koh3nH06tj3Myns1k9mDdJwUj5ZAgsft
 OCa6kynhTR4nzPvnnxqwbv0Asz9klgStnwxKFJhPOGCxt2WHCzAd/BSiYhhUVqvmXIzob
 7cHnW/Eu6GfiG2x39eMlqC+0bBPHgPpCRzjF9YE0ozGUK33iV0HUSmNvud2udrk4bgw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=FKc1I3JY; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c29; helo=mail-oo1-xc29.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=FKc1I3JY
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 42B5460873
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:39:08 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-70059e4dab6so172035eaf.3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792705147; x=1793309947;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=te0RaUn8FKiACGn7kS3yXSgjwS3KtO5AoPE0MAydflE=;
 b=FKc1I3JYwDydd1om1S8IHNOw1zMKAZDpNsuzKLz153Dn3Q5sUo/m8qk00+BEp1l+Um
 cU+0q1N7/9w5FFmMkXhONRyDp3Q4Qwh6x6vnq9B0xyHc/Cb5MBR2V8z7yVpR1/WIaf1Q
 wo83vdg4Gep/AvvMexwxgpgkPD/VEGUXVPxrDmDx/8tPdWmpdR0vSwF1nb962+UhymiI
 vK7gkVkPHpM99y5D+KoqyqLGzq+QgAISFuGn2NNqq1Yn3HSbOuGs+t+h2V4bW0wMKaL5
 E7u7vEAttNteJbcB3fuyzVvpdxbIhWDegGPa2WSRfG4TVb1XhiJI09dzdHeqGRhCWNOL
 THwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792705147; x=1793309947;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=te0RaUn8FKiACGn7kS3yXSgjwS3KtO5AoPE0MAydflE=;
 b=IrSBhNnOINO5GU5xxhzzqrMdmCeM2QANTQX8H0q1MtuJ4GB6tF02hhz7DPOr8M/gxB
 vSqrzIkGNh9U8/HvNyIdPZ0+qirL2JCcHeBfYE6m0Ga5i5kwx4cvCylzKoClD55fnZy+
 NukaKnS7V2T39yeCNKBZIlUskl5Dq/ZggUSitjG3NqeDeD3J7PPG1ljzjuAuF7u8Rj5o
 AtxND62ZUnRf38KSwp1ky+8wlAd10H6j1pfACdaNwBp0Q8vX24BZ1900H4ZwuShBTZgQ
 Fa5zEHiCMeMIlldVv66PPvZYbk+HCsN8V+RjRzrdmmCDW8/Tc1EvIjYDzCAwwzBv91tz
 Ad/w==
X-Forwarded-Encrypted: i=1;
 AKwUvBz32wr2a3oRHm2IKFBJtpoMwytLjqPOnfmac7kgJeuWvnv3iLj0avSD/3SVKZbyNo+pV2W3PMw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLw35IN3KFiYsZQqynWDQPiwPHEsIIs2WpNHOs1b7gUrotLbpnh
 fYEP0ow+18WfTg9usrpDRJ9bm37TEfW8Gw6/cwNDm+ZPtHU5Fn/r3emPlxUBZSVP5mc=
X-Gm-Gg: AYBFou3q7j4SoR6NrWY1iNN+u6WkNs5O0TMqCUNXNhdiK3Imw5RazmfY0N5aWNWY1Ms
 lIIYfTpthnene+/BFGoWO8GIXx4u97StvhX3PcFJ7ORbFIPU3Tvb4z8OikTaJhhNIkoJ7O1GBhM
 Z899KAGFu1RzLk+/EWLXwkUJkDJgRg7rN6ivm34UXiR7L6QGIP/zk/RC+ibgXf9jrxrZvymFJGo
 uO9IVL+79mARupj914MCS9LLW6dqQ051tM7ic0jqEc6raJnXvY3p1RsUpl8R+JdNzmle1+mLMeT
 3qMShE3mB1TUDgt7JG1agn4j6h6sCH5gqCCmOaQHf425lM9BAj3zUAnqmDwn/TA71Of2dnl85TK
 XA8odCc+JtWaW3SbegvW0EL+wRfvtt40jVDR3OrB59Vt55QRR9ulheEVY+WL64ZVYy8aYmkEMXm
 gje0KoiuhpWiEcb9eBzPMegdINN/livFuR+TtBGqB+rOYb/NZuMp3Q6prWz2eLpWxgtyuPPvPdp
 FjuF7uW2oMZOaiaNss8eeI3GjJg6N3Y9XhS9rIFOR93KNspKQdIdzBrpyBt
X-Received: by 2002:a05:6820:760b:b0:702:5ff2:ba2c with SMTP id
 006d021491bc7-70b88b1dc6emr389492eaf.69.1792705147642; 
 Thu, 22 Oct 2026 14:39:07 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d0bd:a587:44ef:f6bb])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-70b8b2088e4sm299034eaf.4.2026.10.22.14.39.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:39:05 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Julien Stephan <jstephan@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Irving-ch Lin <irving-ch.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
In-Reply-To: <20261022-mt8365-add-power-domain-v3-0-90b82ec1e7fa@baylibre.com>
References: <20261022-mt8365-add-power-domain-v3-0-90b82ec1e7fa@baylibre.com>
Subject: Re: [PATCH v3 0/3] Add MediaTek MT8365 power domain support
Message-Id: <179270500288.3711947.4842800819888928455.b4-ty@b4>
Date: Thu, 22 Oct 2026 16:36:42 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1285; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Zkye9CGTzfviMXXRGIg0VwrAcFRQVSV42FoLRxc+YbI=; 
 b=kA0DAAoBwswgAf8Bj8AByyZiAGragnDI4cmeOVz54RvyQuq+nIaEgQ/fW2kk5JXjAcnIJiLJJ
 IkBSgQAAQoANBYhBOwY2Z5iDoPWnNhomMLMIAH/AY/ABQJq2oJwFhxkbGVjaG5lckBiYXlsaWJy
 ZS5jb20ACgkQwswgAf8Bj8DxEQf/We2rnoIAaqAUC0bTrZ9jgnMG8mneNUXURPavuL9b82CVsbL
 la8LW71GvXKTyAfT0zg2Xq2LZl0dhfxp9GnIQnIQ7QU6FZBjo+9qYtMUoqTWrElv1Owd5KcauUg
 YEN3OaRuEG3goB+Btzh2o02/zuGQdtTN5jZCNSMNgwoi7CB6K7tJF6yz18nmslSqTs9QMkhyPg7
 82VopB/IHgQg67a5zcgxoqd5Tqa/OACvvqIw95maKBGTY4gz1RHGGubWwhFwifskvrOjSConBjC
 ZnzTNVaw74RHSz1Ohcclwbeg1gJujRwMbT9KcHM9tpet6+bVrhk1e7rGEBdVyPKO8W0Cvw==
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 22 Oct 2026 16:03:43 +0200, Julien Stephan wrote:
> Add MediaTek MT8365 power domain support
> 
> This series adds the power domain (scpsys) driver for the MediaTek
> MT8365 SoC.
> 
> The scpsys core so far only drove bus protection through the infracfg
> register block. MT8365 also gates some domains through the SMI common
> space and acknowledges its way-enable protections via the read-only
> infracfg "nao" mirror, so the first patch extends the core to select a
> per-step register block before the MT8365 driver is added on top.
> 
> [...]

Applied to mediatek-for-main, thanks!

Made a few minor fixes while applying. Use addr == FDT_ADDR_T_NONE instead of
IS_ERR() for the SMI address. Also reworded comment that said regmap when there
isn't one and added a bit to a commit message to say where MTK_SCPD_STRICT_BUS_PROTECTION
came from.

[1/3] power: domain: mediatek: support SMI and infra-nao bus protection
      commit: 84df39478936c1cecca81c0132d7b3212391dbdf
[2/3] power: domain: mtk: add MT8365 power domain
      commit: 5deda89993f7b978f0eb6e408b589cb35e29a309
[3/3] configs: mt8365: enable the power domain driver
      commit: eee2a50c434c437aeef092109b5bc3c7dcae9ae8

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

