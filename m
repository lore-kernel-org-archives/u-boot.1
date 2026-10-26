Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2E1606A31D
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 12:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PLplkFKW;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=RkvnII+X
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D1B8C40583;
	Mon, 26 Oct 2026 12:18:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QWsI6lKzPClG; Mon, 26 Oct 2026 12:18:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B5F1A404A2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793017136;
	b=rUZZ1Ykbj2PerkEs6QqTtMr9EidoigHhaybYj+nC6dkQ0+iOFzGbejTNfUdDoxmYc7cq
	 Hyl5yvBpfrHG7TBgwM3V4+A/kmuCynVK82QnXyDH1G+0pLgudZVBnqXpL7z8BdhP7ptGH
	 C3p0AnX9K/E8rHzpvbfI+gAK9zbscUk7z6YQMyBPBkezS8tsqKh9c7zDOrBnwLBYvvdUp
	 9RKrwkjFWAhzJsQKre2Z0FvMI/Zb4cWd6SauEK6mh5en32TYN6HjmHYY/ioxLNOyPii2Y
	 q7cawn9dtm+/zvORtIo7akV2PEY7WyvEmcnNZIgqHdlNYkaAyAqgzILa44YMJ7ftapg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793017136;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=w4nmzGz0AI5yeu0Pn/xKHNKJdyfkqI3amI05TfnbCWc=;
	b=bNfKlv9sql/ckq4R0WJhwuIj98FEQun6fGaxYFzKI12wCmiS8yDsuuC2YTxk6y6fDZfb
	 0HpkcST8Ereft1aII57A6Fn/iaiyK8+GsDZ4pTMC32paTGLPBlAKAjP7FaufitOt2cLq/
	 prDeJR3noo11CAE9BiOF/hSSa3svluMjhX8TDyPSq0ehcQki5Kebmt9jyn4jk2BxUPuYG
	 2t6FOYObZ8p/b2GogXau/9DX2emGIDSU1vnZYrgZpJw/MbGv3w7k9NjBGdveET/WVdQ1C
	 J/tUYDcOBj50PbhA4sTSO6zy1+v6xnKgOzEKM9wGlP3Xs+3G18aH5LQHPCQ29eE6qHw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793017136;
	bh=w4nmzGz0AI5yeu0Pn/xKHNKJdyfkqI3amI05TfnbCWc=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PLplkFKWerSEHMQJJTQ8eD25hjeLj8pZF6X/Km8C+ogDuyoiy8+SglQr3IFlfNegw
	 JzTofDoWWLI7Jt0SkQqUuPIFN/rF3FO+RBZ1JCR8MLyq9UosmqTQtRrgb1Cwmc45x3
	 yiM5tGZGRjbjBm/sA5SrfIL0DtFOTqduOfsPoxej0uphRfikp5S5BvjjGh5ZwE6U5l
	 TPqUvjWdYwUXENGmjNg7WRGgDAWvJeLj4Ls6H80HBQ/KAZgmNBNpOvfmZR4e0tUAXs
	 HPHARMk7BRUotekbWLC5CrQ55hbQRfYDYjjttM5V+O2QNj2cjfyyQqwtuMhmHWdVhZ
	 KjeyDwuNdLATg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5F1A404A2;
	Mon, 26 Oct 2026 12:18:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C8B42F5
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 12:18:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 49B1A40072
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 12:18:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UpL75lklSRBV for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 12:18:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EE30E40060
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::534"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793017134;
 b=BSf/PnjwzhaJnm68DGOWM1LGgnkHeDXDQlsVHlnd3rv2FDq0dh3BdaeGAVIzA33Bx5pE
 i8c5xJnSqF44fTQPmaMOpih2b1TWG50BWQnBulCrTKKrBGOVYosdNQq6BYPoTUsB1TDhg
 yMQRPhm4GDNngfgFjDIC666qND+qmBKHQWBRqbwL+lYRKVaVDOrAkcwcVY3cAuVuvrCli
 ugKiz6YwUAQPtvgDrz3lR8gmPq0v7RuZNwF7Y9Q17vP5cBTdN4lUNYXUUb8CP8KWy7fvV
 fuN4q+KgIsRWu66Y9JbjhFU0impYO8VO6/9bU4fySq2z8ilLp5DvCDVhjBdz1U7SxAw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793017134;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=w4nmzGz0AI5yeu0Pn/xKHNKJdyfkqI3amI05TfnbCWc=;
 b=oT/D78MnDUJhGeG4XpYSQ+77n1YJslBEur9KSjNzj2oMnllVj0IlOeuqR91zLoMvRwge
 ElByo4bl2wQX+1NHR9Ls5R9XolpC+HsuHRkEAZIlGtSKLOo+SafWQsNnnglFx5Sz6Kvj0
 D/q7aSYK1qMZa8z0HzL372niT96VyCM4iXaoNknVKKPcoWHfpsjZpuSo07HadFXx/dKKg
 SqkBZNbrdnMDfSjcubb3/zfgFewhxYQ9nflYJ/gNTDqo0ezj53s9oOND45mlG/R+DquHp
 uvaW7pRQNpENba0UOFdTvsTU1QfzBhvz4tHTnN5k4V7s3sfcFIF8S6eSmxVH+ovAANw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=RkvnII+X; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::534"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=RkvnII+X
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EE30E40060
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 12:18:52 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6acb9c018ffso4259148a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 05:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793017130; x=1793621930;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=w4nmzGz0AI5yeu0Pn/xKHNKJdyfkqI3amI05TfnbCWc=;
 b=RkvnII+XHLCCr/YetYh3rjjAbjQyEj2nJAZWDDNcMyfX0i597BrhyaIPe4Xyt05TyA
 hxBBQyespHUA2mrBFzdQT7thUJ4MwSToW3C1au8Eq0TcTgCaGbKq2ulvgMt2I+gJQrDk
 4DBg5NxAspI2YR7zpo/GD9qjWWKd97+wi0rl7NQ06OQ9vdORLpinqZRtpUs+aHDFsn21
 o9k+JTLht6DzfzyoiD+p9WRhLBXVfGbRrpEVA4HzauagNl45Y8vzeZbVyJKeLJbn6pmy
 W2XyNGjDFougkwyvp5rSruiEugQiP7ZJza0jvEiEXgLijhj7Dk13BCso6JdVcQhOdMi3
 8YSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793017130; x=1793621930;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=w4nmzGz0AI5yeu0Pn/xKHNKJdyfkqI3amI05TfnbCWc=;
 b=lpmmcY/9hViG/lByPq1s8+XTaC8fpz9xisUmAAzJnx3iXHG6FadKLkyHy4pRjIZ+/Z
 qMSYaqyj8cJHvAZpR+DQNfCH2FxyEtF5xqeCfta4hLttSAa8mOpWHCMSim0RAR4oBqEW
 Ay+Z32ERfJBi1GANvn4SrsO4xsK4s22oQKOqQnG9z0Ot6SDDaNSglafQ2foONFzq3OX9
 9IFlemC95qQKbrjD5IRZzj4jLYHG0jgPjI9JyJQNDUCk27OFvxbb4OW1gt1sMh9UZFo4
 6LClttijLiaTyw5LkOaLUQNex6k1dFSf1v1WKLiUNB4/b7IRC5FICsonHZE2Apn3aCVr
 ZU/Q==
X-Gm-Message-State: AFq9FYJHSFleZ5yIlLH8KBgZrcRXMULehVDJLVvvLZw7ISlJMNDFxCxR
 GCeYgLbkhrlDrYBSTJPWD+Jqx8JA8vazAeA1oFFkDY7jrA/ElJZ1FTE8naEpLPTR+HU=
X-Gm-Gg: AYBFou0F16nVTtF1pJjftXQ4PYpyDyuFXTLwnqlzf4epkou2fJ+c+OKAFp4w9gxjHVk
 yalYqrwscoQdf/VFzYMEY/y0/xvucGP1W3WXhveEq05MCLbwvXez1jN8buc1T2g4A2fhsq/uqX4
 X1PSThZcAeJehdfwMhFPCBcMwf1yb/zWve3JvYM3knFmKd6lrHBZG/xsJM2JGM8lYLGoCR/tLk/
 zj2obPyzoZBUCags8pX9j97JIFnGK68zzcGHYeXkcw/GnFa+bAL8YUlHZ0HK2MbuRj1x/Cz0rKA
 bawuTM7t3BrSVEMIWe4Sx+fFL6L05WAQ5hGx0CGVziM9ouaRMdIngTE2/cO5+vKl324iohGgZKE
 xcyyn6YkO1awnhmoNv66UW2w4FmHDNwfhOf8NKxzeB1RxAFxlxCjJqlHqfeIdyh9X/zBBn0u4J2
 8QrotHcPldH3L8BGuMIy9a8JESbp2rmtI0nLM22G/7dgeOK+MuyDzHdzfA/kNItPip/GlpXOwPT
 zKx6Z1Fs8iieKHbtPFNCF2ABL6KWavHTZ5bg3w+hE9ibrA5Qqb0oTnSsC+Q7OXxTfs1MJ6HpOGX
 9H6sbRcRazzV6HuJgv4EQc5Gv5MkjyO9DzqStdH3rLTbl5BplusTfLBRTNw+HW3NPUwDa+Zk
X-Received: by 2002:a05:6402:898:b0:6b1:e072:763b with SMTP id
 4fb4d7f45d1cf-6b442fb847dmr5278095a12.5.1793017130115; 
 Mon, 26 Oct 2026 05:18:50 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b467e42f75sm1452800a12.23.2026.10.26.05.18.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 05:18:49 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH v3 0/5] Prepare devicetrees from FIT configurations with
 fdt fit
Date: Mon, 26 Oct 2026 13:18:19 +0100
Message-Id: <20261026-ccaione-upstream-fdt-fit-v3-0-6c5d86c3007f@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43OTW7CMBAF4KsgrzutPQlW6Kr3qLoYO2MyVXGQb
 SIQyt1rwwZ1UbF88/PpXVXmJJzV++aqEi+SZY41dC8b5SeKewYZa1ao0RptLHhP9YThdMwlMR0
 gjAWCFMBdGLpRB7LkVX0/Jg5yvtGfX/ecT+6bfWleu3CUGVyi6Kc2mpPsJb5FPpe2nSSXOV1uz
 RbTlCdKLAY0BIuD5TBgZ/sPR5cfcYlf/XxQrceCDxbiPxZWqze9Zu37cUu7P9a6rr/2rUNpPwE
 AAA==
X-Change-ID: 20261016-ccaione-upstream-fdt-fit-29f83d0fa6ac
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 E Shattow <e@freeshell.de>, David Lechner <dlechner@baylibre.com>, 
 Ahmad Fatoum <a.fatoum@barebox.org>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Randolph Sapp <rs@ti.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Alexey Charkov <alchark@flipper.net>, Vincent Jardin <vjardin@free.fr>, 
 Peter Robinson <pbrobinson@gmail.com>, Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some boards keep a base devicetree and its overlays in a FIT, while the
kernel or EFI application comes from another source. Boot scripts need
a way to verify and assemble that tree without booting an OS from the FIT.

This series adds:

    fdt fit <addr>[#<conf>] <dest> [<len>]

The script loads the FIT into memory with an existing command. fdt fit
then prepares the devicetree described by one configuration, verifies it,
applies its overlays and copies the completed result to the chosen
destination. The script can pass that address to bootefi, booti or
another boot command, and must stop the boot if preparation fails.

The command reuses the FIT loader, always checks image hashes and
enforces any required configuration signatures, even with verify=no.
It rejects chained configurations: signing each configuration separately
does not authenticate their combination. FIT image load addresses are
ignored, so preparation does not write to them before checks complete.

The first three patches provide the loader support, including rejecting
missing or invalid overlays. The last two add the command, documentation
and sandbox tests.

Patch 2 also changes bootm, even when fdt fit is disabled. If a listed
overlay cannot be loaded or verified, bootm now aborts instead of booting
without it. Boards which previously relied on a broken overlay being
skipped must fix their FIT configuration or overlay. The new bootm tests
cover successful preparation and rejection of bad or missing overlays.

This is a new, simpler approach to the firmware-owned devicetree work
previously submitted in the EBBR series [1]. Storage, configuration
selection and boot policy stay in the script. There is no new DT binding,
storage driver or automatic hook into the EFI boot paths.

[1] https://lore.kernel.org/all/20260903-ccaione-upstream-ebbr-v3-0-016658d0b6ba@baylibre.com/

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
Changes in v3:
- Make patch 2's bootm behaviour change explicit in its commit message
  and the cover letter.
- Add direct bootm tests for valid, corrupted-hash and missing overlays,
  independent of CMD_FDT_FIT.
- Collect Simon Glass's remaining Reviewed-by tags for patch 3 and the cover.
- Link to v2: https://patch.msgid.link/20261022-ccaione-upstream-fdt-fit-v2-0-4140e0c4d5a9@baylibre.com

Changes in v2:
- Clarify that load_op controls only the base devicetree and document the
  overlay policy and enum values.
- Collect Simon Glass's Reviewed-by tags for patches 1, 2, 4 and 5.
- Link to v1: https://patch.msgid.link/20261016-ccaione-upstream-fdt-fit-v1-0-f6286ef82364@baylibre.com

---
Carlo Caione (5):
      boot: fit: tell callers when a devicetree buffer must be freed
      boot: fit: reject configurations with missing or invalid overlays
      boot: fit: let callers choose where to place the devicetree
      cmd: fdt: add 'fdt fit' to prepare a devicetree for other boot commands
      test: py: cover fdt fit preparation and failure handling

 boot/image-fdt.c              |   4 +-
 boot/image-fit.c              |  84 +++++++---
 cmd/Kconfig                   |   9 +
 cmd/fdt.c                     |  83 ++++++++++
 configs/sandbox_defconfig     |   1 +
 doc/usage/cmd/fdt.rst         |  75 +++++++++
 include/image.h               |  11 +-
 test/py/tests/test_fdt_fit.py | 371 ++++++++++++++++++++++++++++++++++++++++++
 test/py/tests/test_fit.py     |  60 +++++++
 9 files changed, 676 insertions(+), 22 deletions(-)
---
base-commit: ed869863c7e2aca50d57a05d843830dd843138c4
change-id: 20261016-ccaione-upstream-fdt-fit-29f83d0fa6ac

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

