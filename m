Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48282606A31D
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 17:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Qq5/RDcs;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=kaqFXpRg
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1FF866085E;
	Tue, 20 Oct 2026 17:26:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mQc9nWJADA_J; Tue, 20 Oct 2026 17:26:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C86A3607B8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792517193;
	b=MhXkV45g4xz0akp/lcgvpKcp84bqu8kCHVk/ljLFzvrkZfmj2wNnR5n5aEeZ8+N3uK1n
	 TwbfizNjFjzJBxoYFlpHyV6fBw0WcAMEUlOBUkiI3NmQcYu2YAXGDzec7J9rIs4TgZBOO
	 oARTkKbMZ/KVEQzMTTPVzrVDLMiV5aKLWMN9WqwxQyC3SvO4edXQ2zJjid+yFVXS7kP03
	 jUICAl5pBOuRYAlj9IT1di8Z9Ktlpq231Gvt18DLAgDrBNpJ/wWzom3IIqS1Cf2TGjtYf
	 +3peGWlw4jXWVdgtXdxl2xyxpWQ7WzAAtI1OHcEDhBUKMFAUJ7jWYmCHDNnuy3ok1yA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792517193;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6WOv8zj4x/mWgnM19CzTePhBCZ0lG+bFDsX6+VuGsuk=;
	b=IRP0cFAZOoVfwxqhAFvlEf39pRhHtB3aaFNuZ9W8JNxl/EBe4cA9QOs5TtXtt7DcvMEe
	 HxL/YHQvDIVy/IB/NOQPSb3vdV1GCGKQ5kt56Devp2KvgJ8oVQIg3ux1QZC7+FDri1xjB
	 k50Gcy1S5w4liDbrf4nxyJ+51UPfyhfydOEJfkSons3TNKkuPcC5e0noex4XzHRpZl5gZ
	 w/PVaNCMz7Q9Y4v2y4wsCchjGUjfKLDWa/gTBEV72hp++dKTbzKXSoXw1aEQduHaUXHKc
	 bAQm4t47XvjVO7jMpQlTSFAgzMV660/fuIhQ33bFSUW+LAmupqxcLmG/FNVah9f+XHg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=kaqFXpRg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792517192;
	bh=6WOv8zj4x/mWgnM19CzTePhBCZ0lG+bFDsX6+VuGsuk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qq5/RDcsLguHm13NSmLZtAESNfbHNvzEef68cXOiRiv5EmhjkVp/iu2T+BG8GVwvb
	 +LAxSB5VNHHlng1XHE+CwcSQj2aNcROCpAnrkvcvTneLeVwpQQUQ9r3hH4P1vpOl97
	 kxKmooPsAN5KV4lxQEfRrce6+zf61j5vNv5H5MNx7Yaz18iLOSqphqn5yEbi1GiI5x
	 dQVFLdXSewWZjwNWONQU9njBOcDeA+NgBzLpD3+soXkqZJuPUBaWqJ8r7+eRrFpFxe
	 RQ+Ki5Cl3wdTIOhP9hZJMyuWj48VxSQN5iX9mKFj9C6u4oxe5bCHVoBKcfhR9z7Fbd
	 gclyA51/NJ0jQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C86A3607B8;
	Tue, 20 Oct 2026 17:26:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BF7223A4
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:43:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A557E60773
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:43:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fJCj3vE1-inc for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 16:43:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E3AB26071D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792514594;
 b=iW+0rOp+OcKKcj+hM84mMNlLsvKWG5a0P25aLX3wxWoTxoOCDVdxLLyqUqZcCwPDM8M5
 WUKwDPc3bJGrubVnFLlRXScmOOx33cc62G7/NC4LicrYL99g0ktiN8ygrsqdSziHxirRd
 sEc4R/KrPpGd7rCp9JkY3LkrlRC+5V/r+nvWfPWxzs0hmVW3zwRKL9J6vaD+8REXjBv03
 rM+cpFAoZYsWzYwtgJX8oWPAbv5BygsN9D9QlSW/skgYGrs0d2AK5dc8VZeKAX93VnVDF
 lBYR0d13gqMIlPRuKBVHNWQqfzvhSScEuRl2G1eU1C1Yre5wxMpqt7S6Bc6XYELvrRw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792514594;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=6WOv8zj4x/mWgnM19CzTePhBCZ0lG+bFDsX6+VuGsuk=;
 b=lStSg0j0R6CdIeBTPKYLWRJVqFNAfwGsULRjZ8hjK13bJfzNLEd2tZb+YKdYt9CIKV+o
 2gFNZhGOtSQ0mpzPXXzWQisoZulj44+SpQ+EnLtni2StY2mZhyB/GtYip0nCwwutQCGos
 QxhYlH60lmPheziB+2XyaYShKtg1wybRQ37GraddV6NBGw9gT9buuefKbFDwodNxDjfNb
 52o4f2zOVWXpBUu1H524V8eUogzMQj37NZ82IRn2lrbuZfb81IsvVsQw1YdoSZnxpuH9z
 bnYHUKN90JwmpKOzYzuUQjXgXsMGvrzG50vi9foulZ6EEvZT439l9V9ZABB9AH7Wd+w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=kaqFXpRg; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=kaqFXpRg
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E3AB26071D
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:43:13 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a1cef0439aso37991335e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792514591; x=1793119391;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6WOv8zj4x/mWgnM19CzTePhBCZ0lG+bFDsX6+VuGsuk=;
 b=kaqFXpRgA36TFj+j8+x7Hh96DE3gq5JXknSv1pXlAxZQC3+5NIvlYdTGxiV3oAvUa6
 EblDuK8qgDEHsYJbbJiBrnljLI71fusZZlt/Evqj3ugEL3rdaFz9m1KlTnMP5Silr/mA
 D6JaJnTiMy9LRkkxCxKBZHOaxq2TuhP1lSCO+x5EMgLlyeCdN2+ylOmngAx4R0+D0Vu3
 B9+XhDvMcrujDtg4sy20BfNDhfjaCdZ4gIT4RGUD6IV19SKtrwzgf6+cqSkMnHcwqATd
 ilNzk3Kk0o67uzbsHl4rZtCHPMcT6mz6rabHxD5M3cMb1OWQ04lSY+p7GVgLXrElKjyw
 lcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792514591; x=1793119391;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6WOv8zj4x/mWgnM19CzTePhBCZ0lG+bFDsX6+VuGsuk=;
 b=nn0CIarPGrHjrsw+XdPbpWSjhJM86RZhWvaVul+ellfaxC2aEybxLtVzwhswTbWQc6
 sfnUt88VU270KIQzdvwaHDxC8UZQEPJzYf8B11D1Hbj4IPNYKkr0bWFSY7F6LjtytbSL
 bO9h38peCNinm99Wo6Vxzhb4FZnajegceJSI5D2sKOvj0Pj0QFRqxqcutnu5YO7fjk+u
 HoUGVHmiOywSLY9cWDQCVZLmZTDpKqjbnhfHD5Yag/LK0RJ6oxAD7iz3gN3miO4kcnta
 t2rm+8GUvvriaGQRzP582aRT7TV9y3y4Y1FWpnorJ+uGsuR0PmHTsaM/6GNB3DqqpCDH
 fAkQ==
X-Gm-Message-State: AFq9FYKYDd3j5FdnfnJDmq+sSoUlgZfUzURyZaxTwR7CZ5ROnXvNwzQe
 SxWZqI1QWIF9jfLZzvslMbMMFf3GfL820UQ9JLR7oq5GdvfKMvu0LkV5kSgdVQLSZZA=
X-Gm-Gg: AYBFou18KoVwdCM/kvLtVp9I7iXHIVmMhFLF9BVtBkyrICpsl3XJ9+6IuiZemlh1Xfm
 4EIo2tb8yu5UkB5+Q473CAvF1PIVX6+IZBVRjtvpYGH17vcJZAlz9qeJ4VH4lNTXBjfLYudo2D1
 WDEcp5IUYMe89DE9RxXs5rb6yscHCh5RLxvug7o98g5rb/zKIOwaAWTXAuKA36eVNZE37gd0P6h
 SQzon0Eyw3e9T4LsVoolNdFjHz1DA6Ro+j3GL1u/nHGhsJF0hLCbyKRsPdnW12vrN6Z85KJRVcv
 2G1ztUxDv1VKE0bfckQM/8MO/Le94EjWEc+OzBN0VmE2S7cqem1n+DAIwaZn1pmxvcb2HvcoMDI
 Oow5t593qo+zMDniu1F62ldqdX4GgvCzthBPfGVpjYBymZoFGY/H7XbFpB0QwulmYPpZntENNkh
 BpvcKEy64JEaF/2a9uso3WAjQQEg3ESG8BBgFh9JkiKxY/gKN0D2iK0EAZFOoTctj8Rerg/r+a7
 vrheMlnEJcfFjihc+fNLh0V/1cO019T66WGzKq19QYKS+a7Wg4T6w==
X-Received: by 2002:a05:600c:8706:b0:49c:fc6c:be19 with SMTP id
 5b1f17b1804b1-4a1d76224f0mr249228385e9.31.1792514591408; 
 Tue, 20 Oct 2026 09:43:11 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae.
 [86.98.194.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fc10de99sm643315e9.1.2026.10.20.09.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 09:43:11 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 20 Oct 2026 20:41:05 +0400
Subject: [PATCH v3 18/23] binman: Allow choosing the compression level
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-spl-fit-compression-v3-18-6647aa23ade5@flipper.net>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
In-Reply-To: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
To: u-boot@lists.u-boot-project.org, Sean Anderson <seanga2@gmail.com>
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>, 
 Simon Glass <sjg@chromium.org>, Francesco Valla <francesco@valla.it>, 
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>, Max Merchel <max.merchel@ew.tq-group.com>, 
 u-boot@ew.tq-group.com, Petr Hodina <petr.hodina@protonmail.com>, 
 Bruno Banelli <bbanelli@gmail.com>, Carlo Caione <ccaione@baylibre.com>, 
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marex@nabladev.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Mehmet Fide <mehmet.fide@screeningeagle.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=21337; i=alchark@flipper.net; 
 h=from:subject:message-id;
 bh=r7HQA+QrmZt+jtE17MpN+3KBmWH2HT5NH2yydBQeinM=; 
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRdn7k6+67INKtJ0rxZu07Wzl6VWs7ZeaZS4u2nJUzBK
 XxGMtc4OyayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAZjqLnlGhgXe99w2lh68r3auUH67hOvt5I25TOmOkd2eXRKKvOuvKzP8Ty6z3SI
 n4Bzx3Pv15O6Qd8XNPt977C578Tn3Pd1i+O8PHwA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Tue, 20 Oct 2026 17:26:00 +0000
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

Every compression algorithm binman drives has a level, and the best one
to use depends on what the image is for: a payload sent over USB wants
the smallest it can get, one read from fast storage would rather not
wait for it. Today only the tool's own default is reachable.

Add a 'compress-level' property, passed through as -<level>, which is how
all compressors want it except lzma: the LZMA SDK tool has no such option,
and is controlled by the -lc/-lp/-pb values binman already passes.

Have each tool declare the levels it takes, and reject anything outside
them with the node's path, whether or not the tool is installed. The tools
do not reliably refuse a bad level themselves: gzip, bzip2, xz and lzop
read -12 as -1 -2 and quietly compress at level 2, and a typo or a
leftover level after switching algorithms would otherwise just produce a
larger image with nothing to say why.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 tools/binman/binman.rst                            | 21 ++++++
 tools/binman/bintool.py                            | 20 +++++-
 tools/binman/btool/btool_gzip.py                   |  2 +-
 tools/binman/btool/bzip2.py                        |  3 +-
 tools/binman/btool/lz4.py                          |  9 ++-
 tools/binman/btool/lzma_alone.py                   |  5 +-
 tools/binman/btool/lzop.py                         |  2 +-
 tools/binman/btool/xz.py                           |  3 +-
 tools/binman/btool/zstd.py                         |  3 +-
 tools/binman/entry.py                              | 18 ++++-
 tools/binman/etype/blob.py                         |  5 ++
 tools/binman/ftest.py                              | 81 ++++++++++++++++++++++
 tools/binman/test/entry/compress_level.dts         | 12 ++++
 tools/binman/test/entry/compress_level_gzip.dts    | 12 ++++
 tools/binman/test/entry/compress_level_lzma.dts    | 12 ++++
 .../test/entry/compress_level_no_compress.dts      | 11 +++
 tools/binman/test/entry/compress_level_range.dts   | 12 ++++
 tools/binman/test/entry/compress_level_zero.dts    | 12 ++++
 18 files changed, 230 insertions(+), 13 deletions(-)

diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
index 3a860421a697..c661f31a7d8d 100644
--- a/tools/binman/binman.rst
+++ b/tools/binman/binman.rst
@@ -711,6 +711,11 @@ compress:
     Sets the compression algorithm to use (for blobs only). See the entry
     documentation for details.
 
+compress-level:
+    Sets how hard the compression algorithm should try, as the level number
+    the tool itself uses. Requires 'compress'. See the entry documentation
+    for details.
+
 missing-msg:
     Sets the tag of the message to show if this entry is missing. This is
     used for external blobs. When they are missing it is helpful to show
@@ -1182,6 +1187,22 @@ The entry will then contain the compressed data, using the 'lz4' compression
 algorithm. Currently this is the only one that is supported. The uncompressed
 size is written to the node in an 'uncomp-size' property, if -u is used.
 
+Where an algorithm offers a choice of how hard to try, 'compress-level' passes
+one through::
+
+    blob {
+        filename = "datafile";
+        compress = "zstd";
+        compress-level = <19>;
+    };
+
+The number is the tool's own level, so its meaning follows that tool. Binman
+accepts 1 to 9 for gzip, bzip2, lzo and xz, 1 to 12 for lz4 and 1 to 19 for
+zstd, and reports anything else as an error rather than leave the tool to
+reinterpret it. Leaving the property out uses the level binman has always used:
+the tool's own default, except for lz4, which gets 5. It cannot be used with
+'lzma', whose LZMA SDK tool has no such option.
+
 Compression is also supported for sections. In that case the entire section is
 compressed in one block, including all its contents. This means that accessing
 an entry from the section requires decompressing the entire section. Also, the
diff --git a/tools/binman/bintool.py b/tools/binman/bintool.py
index 4cf8d5b165bf..096cfc5c5fa4 100644
--- a/tools/binman/bintool.py
+++ b/tools/binman/bintool.py
@@ -59,6 +59,10 @@ class Bintool:
     # Flag to run 'apt-get update -y' once on first use of apt_install()
     apt_updated = False
 
+    # Highest level a compression tool accepts, from 1 up, or None if it has
+    # no notion of one
+    max_level = None
+
     def __init__(self, name, desc, version_regex=None, version_args='-V'):
         self.name = name
         self.desc = desc
@@ -542,12 +546,16 @@ class BintoolPacker(Bintool):
             property if none
         version_regex: Regular expressions to extract the version from tool
             version output,  '(v[0-9.]+)' if none
+        max_level: Highest compression level the tool accepts as -<level>,
+            or None if it takes none
     """
     def __init__(self, name, compression=None, compress_args=None,
                  decompress_args=None, fetch_package=None,
-                 version_regex=r'(v[0-9.]+)', version_args='-V'):
+                 version_regex=r'(v[0-9.]+)', version_args='-V',
+                 max_level=None):
         desc = '%s compression' % (compression if compression else name)
         super().__init__(name, desc, version_regex, version_args)
+        self.max_level = max_level
         if compress_args is None:
             compress_args = ['--compress']
         self.compress_args = compress_args
@@ -558,11 +566,14 @@ class BintoolPacker(Bintool):
             fetch_package = name
         self.fetch_package = fetch_package
 
-    def compress(self, indata):
+    def compress(self, indata, level=None):
         """Compress data
 
         Args:
             indata (bytes): Data to compress
+            level (int): Compression level to use, from 1 to max_level, or
+                None for the tool's own default. Every packer tool spells
+                this as -<level>.
 
         Returns:
             bytes: Compressed data
@@ -570,7 +581,10 @@ class BintoolPacker(Bintool):
         with tempfile.NamedTemporaryFile(prefix='comp.tmp',
                                          dir=tools.get_output_dir()) as tmp:
             tools.write_file(tmp.name, indata)
-            args = self.compress_args + ['--stdout', tmp.name]
+            args = self.compress_args[:]
+            if level is not None:
+                args.append(f'-{level}')
+            args += ['--stdout', tmp.name]
             return self.run_cmd(*args, binary=True)
 
     def decompress(self, indata):
diff --git a/tools/binman/btool/btool_gzip.py b/tools/binman/btool/btool_gzip.py
index 0d75028120fe..de628b168c6d 100644
--- a/tools/binman/btool/btool_gzip.py
+++ b/tools/binman/btool/btool_gzip.py
@@ -28,4 +28,4 @@ class Bintoolgzip(bintool.BintoolPacker):
     """
     def __init__(self, name):
         super().__init__(name, compress_args=[],
-                         version_regex=r'gzip ([0-9.]+)')
+                         version_regex=r'gzip ([0-9.]+)', max_level=9)
diff --git a/tools/binman/btool/bzip2.py b/tools/binman/btool/bzip2.py
index c3897d63acb5..9cc30dcba19b 100644
--- a/tools/binman/btool/bzip2.py
+++ b/tools/binman/btool/bzip2.py
@@ -27,4 +27,5 @@ class Bintoolbzip2(bintool.BintoolPacker):
         man bzip2
     """
     def __init__(self, name):
-        super().__init__(name, version_regex=r'bzip2.*Version ([0-9.]+)', version_args='--help')
+        super().__init__(name, version_regex=r'bzip2.*Version ([0-9.]+)', version_args='--help',
+                         max_level=9)
diff --git a/tools/binman/btool/lz4.py b/tools/binman/btool/lz4.py
index fd520d13a566..609a4724c92b 100644
--- a/tools/binman/btool/lz4.py
+++ b/tools/binman/btool/lz4.py
@@ -77,20 +77,25 @@ class Bintoollz4(bintool.Bintool):
     """
     def __init__(self, name):
         super().__init__(name, 'lz4 compression', r'.* (v[0-9.]*),.*')
+        self.max_level = 12
 
-    def compress(self, indata):
+    def compress(self, indata, level=None):
         """Compress data with lz4
 
         Args:
             indata (bytes): Data to compress
+            level (int): Compression level (1 to 12), or None for the level
+                5 binman has always used here
 
         Returns:
             bytes: Compressed data
         """
+        if level is None:
+            level = 5
         with tempfile.NamedTemporaryFile(prefix='comp.tmp',
                                          dir=tools.get_output_dir()) as tmp:
             tools.write_file(tmp.name, indata)
-            args = ['--no-frame-crc', '-B4', '-5', '-c', tmp.name]
+            args = ['--no-frame-crc', '-B4', f'-{level}', '-c', tmp.name]
             return self.run_cmd(*args, binary=True)
 
     def decompress(self, indata):
diff --git a/tools/binman/btool/lzma_alone.py b/tools/binman/btool/lzma_alone.py
index 1fda2f68c7b4..b5630dc618a1 100644
--- a/tools/binman/btool/lzma_alone.py
+++ b/tools/binman/btool/lzma_alone.py
@@ -55,11 +55,14 @@ class Bintoollzma_alone(bintool.Bintool):
     def __init__(self, name):
         super().__init__(name, 'lzma_alone compression')
 
-    def compress(self, indata):
+    def compress(self, indata, level=None):
         """Compress data with lzma_alone
 
         Args:
             indata (bytes): Data to compress
+            level (int): Unused: the LZMA SDK tool has no -<level> option,
+                and is steered by the -lc/-lp/-pb/-d values below instead.
+                With max_level left at None, Entry rejects a level anyway.
 
         Returns:
             bytes: Compressed data
diff --git a/tools/binman/btool/lzop.py b/tools/binman/btool/lzop.py
index f6903b4db75e..8760f843ecaa 100644
--- a/tools/binman/btool/lzop.py
+++ b/tools/binman/btool/lzop.py
@@ -27,4 +27,4 @@ class Bintoollzop(bintool.BintoolPacker):
         man lzop
     """
     def __init__(self, name):
-        super().__init__(name, 'lzo', compress_args=[])
+        super().__init__(name, 'lzo', compress_args=[], max_level=9)
diff --git a/tools/binman/btool/xz.py b/tools/binman/btool/xz.py
index e2b413d18bda..23b90180f7e1 100644
--- a/tools/binman/btool/xz.py
+++ b/tools/binman/btool/xz.py
@@ -28,4 +28,5 @@ class Bintoolxz(bintool.BintoolPacker):
     """
     def __init__(self, name):
         super().__init__(name, fetch_package='xz-utils',
-                         version_regex=r'xz \(XZ Utils\) ([0-9.]+)')
+                         version_regex=r'xz \(XZ Utils\) ([0-9.]+)',
+                         max_level=9)
diff --git a/tools/binman/btool/zstd.py b/tools/binman/btool/zstd.py
index 299bd371269e..aac16172b5c3 100644
--- a/tools/binman/btool/zstd.py
+++ b/tools/binman/btool/zstd.py
@@ -27,4 +27,5 @@ class Bintoolzstd(bintool.BintoolPacker):
         man zstd
     """
     def __init__(self, name):
-        super().__init__(name)
+        # Levels past 19 need --ultra, which binman does not pass
+        super().__init__(name, max_level=19)
diff --git a/tools/binman/entry.py b/tools/binman/entry.py
index 9b39c7118892..bd1f4dfc5a1b 100644
--- a/tools/binman/entry.py
+++ b/tools/binman/entry.py
@@ -143,6 +143,7 @@ class Entry(object):
         self.image_pos = None
         self.extend_size = False
         self.compress = 'none'
+        self.compress_level = None
         self.missing = False
         self.faked = False
         self.external = False
@@ -325,6 +326,9 @@ class Entry(object):
 
         # This is only supported by blobs and sections at present
         self.compress = fdt_util.GetString(self._node, 'compress', 'none')
+        self.compress_level = fdt_util.GetInt(self._node, 'compress-level')
+        if self.compress_level is not None and self.compress == 'none':
+            self.Raise("'compress-level' requires 'compress'")
         self.offset_from_elf = fdt_util.GetPhandleNameOffset(self._node,
                                                              'offset-from-elf')
 
@@ -1222,7 +1226,7 @@ features to produce new behaviours.
         if self.compress != 'none':
             self.uncomp_size = len(indata)
             if self.comp_bintool.is_present():
-                data = self.comp_bintool.compress(indata)
+                data = self.comp_bintool.compress(indata, self.compress_level)
                 uniq = self.GetUniqueName()
                 fname = tools.get_output_filename(f'comp.{uniq}')
                 tools.write_file(fname, data)
@@ -1293,7 +1297,8 @@ features to produce new behaviours.
             btools (dict of Bintool):
 
         Raise:
-            ValueError if compression algorithm is not supported
+            ValueError if compression algorithm is not supported, or does not
+                support the compression level asked for
         """
         algo = self.compress
         if algo != 'none':
@@ -1304,6 +1309,15 @@ features to produce new behaviours.
             name = names.get(self.compress, self.compress)
             self.comp_bintool = self.AddBintool(btools, name)
 
+            # Check here, so that it is reported even if the tool is missing
+            level = self.compress_level
+            max_level = self.comp_bintool.max_level
+            if level is not None and max_level is None:
+                self.Raise(f"'compress-level' is not supported by '{algo}'")
+            if level is not None and not 1 <= level <= max_level:
+                self.Raise(f"'compress-level' must be 1 to {max_level} "
+                           f"for '{algo}'")
+
     @classmethod
     def AddBintool(self, tools, name):
         """Add a new bintool to the tools used by this etype
diff --git a/tools/binman/etype/blob.py b/tools/binman/etype/blob.py
index acd9ae34074e..111c31d4ba55 100644
--- a/tools/binman/etype/blob.py
+++ b/tools/binman/etype/blob.py
@@ -22,6 +22,11 @@ class Entry_blob(Entry):
         - compress: Compression algorithm to use:
             none: No compression
             lz4: Use lz4 compression (via 'lz4' command-line utility)
+        - compress-level: How hard to compress, as the level number the
+            compression tool itself uses (e.g. 1 to 9 for gzip). Requires
+            'compress' and an algorithm which has levels, so not 'lzma'.
+            Without it, binman uses the tool's default, except for lz4, for
+            which it has always passed level 5 instead
 
     This entry reads data from a file and places it in the entry. The
     default filename is often specified specified by the subclass. See for
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 8caf275d4664..0c45c7207e44 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -2168,6 +2168,87 @@ class TestFunctional(unittest.TestCase):
         bintool = self.comp_bintools['lz4']
         return bintool.decompress(data)
 
+    def _ReadFileRecordingArgs(self, name, fname):
+        """Build an image, recording the arguments a bintool is run with
+
+        Args:
+            name (str): Name of the bintool to record
+            fname (str): Device tree source filename to build
+
+        Returns:
+            tuple:
+                bytes: Image data
+                list of tuple: Arguments of each run of that bintool
+        """
+        original = bintool.Bintool.run_cmd
+        calls = []
+
+        def recording_run_cmd(self_tool, *args, binary=False):
+            if self_tool.name == name:
+                calls.append(args)
+            return original(self_tool, *args, binary=binary)
+
+        with unittest.mock.patch.object(bintool.Bintool, 'run_cmd',
+                                        new=recording_run_cmd):
+            data = self._DoReadFile(fname, use_real_dtb=True)
+        return data, calls
+
+    def testCompressLevel(self):
+        """Test that a compression level reaches the tool and round-trips"""
+        self._CheckLz4()
+        data, calls = self._ReadFileRecordingArgs('lz4',
+                                                  'entry/compress_level.dts')
+        self.assertEqual(COMPRESS_DATA, self._decompress(data))
+        self.assertTrue(calls)
+        for args in calls:
+            self.assertIn('-12', args)
+            self.assertNotIn('-5', args)
+
+    def testCompressLevelPacker(self):
+        """Test a compression level reaching a tool binman drives generically"""
+        btool = self.comp_bintools['gzip']
+        self._CheckBintool(btool)
+        data, calls = self._ReadFileRecordingArgs(
+            'gzip', 'entry/compress_level_gzip.dts')
+        self.assertEqual(COMPRESS_DATA, btool.decompress(data))
+        self.assertTrue(calls)
+        for args in calls:
+            self.assertIn('-9', args)
+
+    def testCompressLevelUnsupported(self):
+        """Test that lzma rejects a level its tool cannot express"""
+        with self.assertRaises(ValueError) as e:
+            self._DoReadFile('entry/compress_level_lzma.dts',
+                             use_real_dtb=True)
+        self.assertIn(
+            "Node '/binman/blob': 'compress-level' is not supported by 'lzma'",
+            str(e.exception))
+
+    def testCompressLevelRange(self):
+        """Test that a compression level beyond the tool's range is rejected"""
+        with self.assertRaises(ValueError) as e:
+            self._DoReadFile('entry/compress_level_range.dts',
+                             use_real_dtb=True)
+        self.assertIn(
+            "Node '/binman/blob': 'compress-level' must be 1 to 9 for 'gzip'",
+            str(e.exception))
+
+    def testCompressLevelZero(self):
+        """Test that a compression level of 0 is rejected"""
+        with self.assertRaises(ValueError) as e:
+            self._DoReadFile('entry/compress_level_zero.dts',
+                             use_real_dtb=True)
+        self.assertIn(
+            "Node '/binman/blob': 'compress-level' must be 1 to 12 for 'lz4'",
+            str(e.exception))
+
+    def testCompressLevelNoCompress(self):
+        """Test that a compression level without an algorithm is rejected"""
+        with self.assertRaises(ValueError) as e:
+            self._DoReadFile('entry/compress_level_no_compress.dts',
+                             use_real_dtb=True)
+        self.assertIn("'compress-level' requires 'compress'", str(e.exception))
+
     def testCompress(self):
         """Test compression of blobs"""
         self._CheckLz4()
diff --git a/tools/binman/test/entry/compress_level.dts b/tools/binman/test/entry/compress_level.dts
new file mode 100644
index 000000000000..78c999590469
--- /dev/null
+++ b/tools/binman/test/entry/compress_level.dts
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	binman {
+		blob {
+			filename = "compress";
+			compress = "lz4";
+			compress-level = <12>;
+		};
+	};
+};
diff --git a/tools/binman/test/entry/compress_level_gzip.dts b/tools/binman/test/entry/compress_level_gzip.dts
new file mode 100644
index 000000000000..d2852fd653dd
--- /dev/null
+++ b/tools/binman/test/entry/compress_level_gzip.dts
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	binman {
+		blob {
+			filename = "compress";
+			compress = "gzip";
+			compress-level = <9>;
+		};
+	};
+};
diff --git a/tools/binman/test/entry/compress_level_lzma.dts b/tools/binman/test/entry/compress_level_lzma.dts
new file mode 100644
index 000000000000..da52497b11a0
--- /dev/null
+++ b/tools/binman/test/entry/compress_level_lzma.dts
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	binman {
+		blob {
+			filename = "compress";
+			compress = "lzma";
+			compress-level = <5>;
+		};
+	};
+};
diff --git a/tools/binman/test/entry/compress_level_no_compress.dts b/tools/binman/test/entry/compress_level_no_compress.dts
new file mode 100644
index 000000000000..1e58202ce639
--- /dev/null
+++ b/tools/binman/test/entry/compress_level_no_compress.dts
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	binman {
+		blob {
+			filename = "compress";
+			compress-level = <9>;
+		};
+	};
+};
diff --git a/tools/binman/test/entry/compress_level_range.dts b/tools/binman/test/entry/compress_level_range.dts
new file mode 100644
index 000000000000..bee98ffc7429
--- /dev/null
+++ b/tools/binman/test/entry/compress_level_range.dts
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	binman {
+		blob {
+			filename = "compress";
+			compress = "gzip";
+			compress-level = <12>;
+		};
+	};
+};
diff --git a/tools/binman/test/entry/compress_level_zero.dts b/tools/binman/test/entry/compress_level_zero.dts
new file mode 100644
index 000000000000..96caeaa361d6
--- /dev/null
+++ b/tools/binman/test/entry/compress_level_zero.dts
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	binman {
+		blob {
+			filename = "compress";
+			compress = "lz4";
+			compress-level = <0>;
+		};
+	};
+};

-- 
2.55.0

