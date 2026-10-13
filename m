Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B8FCA9ED0
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 05:47:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 794B180960;
	Tue, 13 Oct 2026 05:47:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RxMjpTiRSDF9; Tue, 13 Oct 2026 05:47:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A3ADD808C1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791870464;
	b=fgPAzeIEeJfuuP6KywWOHp4qM1j8XswN/cTFY9WufdWzMnSZh1N4rCEcEljTtY/ZsW/2
	 B2Y1fWL3nojxvuE/tzEM7891S5NN8E2zkGNdZ0wtwNtwRmu7Gmwx4mj3u38SHVh1xao7O
	 iezK5ogc797uPHhF5LleFDH3KG6sGOHJAU7nGKSmw63xkZp9oE7g3Uw6Y1oe2hm2y6aVn
	 vIxEmpYexMwIJWXhmYAfmgPy5HQyIp/FQJRKNwbnv4K6ktWS1t5M4FCDMAfV4Os6dyRuQ
	 ml1PoFW0gB1bD504PVW9qRrf//J0WjQg2yczEuI1W1a1GxA43+ok5bhdnsHf6Lky0uQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791870464;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=RG+2pAW6gYFrX+/VYNtPrm2PQmFJqmGj3nOw0IS4h0s=;
	b=dXyyxoDHB0TZOWK/+aDbsDuRRJ1W5iPLj6J6EgPNYMlruDk/umB0h4HevO9t90DsKGy6
	 Uafo52D29zOkjBTgoR8M9iWC5qna6mQMM6eFfInKCneq4gaA72rI2DkGK0m7eZYP6u6+U
	 8/gdFJt90rLhuLHU0eWaTNMSsErjS/EHnhb6WyuJlsdj7JP4rHLovrJQS8YJQAoUhJElN
	 x7axjN14c1ROhnOCPreQonNcjwFBIVnImvFQNo427HjHZVqlPMufbOXT9urDo5ddbBmPx
	 hsMmTKwXIkC301Q6vTR21o/9JooqXYlYrveZQz4MYA2Ogre9tw8QUVE++botSuIy96Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791870464;
	bh=RG+2pAW6gYFrX+/VYNtPrm2PQmFJqmGj3nOw0IS4h0s=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kualPtud1nHxtPxyx7M/EwKpzxSQ2nF9U+JWq4IfZtmiBqUzngZEmnHerDY0OlGbW
	 GdGeSlJpiKV5zYih0Gs4GFJjKFP3Ey7KmZ4YRyzpxG5rKcYKNVv58zF1nhC6yqF8ZB
	 7CdJD5sQalx4pPNVoFHzrTTxSWrbk7SLZctuntBTE/nYZcPdEn5NP5TToHHKiNMuTV
	 p6prppuGZwH9FwooQyVDKgKezV4H5/huIWstgJ85B8EKtXK3tyfZhA4o8XdoAAD8TF
	 Jc8eel40KqZLuXOGFw92p/V3m5udPzJ3rNmVTUQEUeSDVHuld4hDPtXJ9ftC8zlgpv
	 3ZVBqX6NKgq/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A3ADD808C1;
	Tue, 13 Oct 2026 05:47:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B7D04DD
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 04:31:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 986D14054E
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 04:31:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qCyJDNga2lYL for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 04:31:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4040140545
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791865877;
 b=qtDaBkui4074sWiENt8sft6ozY+XptQo/p8hsumWsKLY68EPmT8ckb5Q69FEAQudz0LS
 334xvk2k4a5syoHwjS6ZSRHipaPMl8ntqf1xDB8f+uMIawZAdrdXd2XjNZQH3VWZRlYJa
 HSCZHQGg6xst93Ukh84s1PRWfGv9Fv0EBITKPF3uCWDO/azSU+o4SpiWYZ524QacFLpGb
 gZxX6n7t39QKnmauDxeG8hVHSefbIRkuptDWg64BZC1knVkn9pTBheXcH0x2ZxGDJX2RJ
 uTfH6naXoP1GuTbjv5ewqdp9u+gqlu6duhqTnNBktkJsv7/pMdNAS3Xp9/+y14q9NtA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791865877;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:Content-Transfer-Encoding;
 bh=RG+2pAW6gYFrX+/VYNtPrm2PQmFJqmGj3nOw0IS4h0s=;
 b=mz2ytsmgc8d3snAVlWbsBOgwMbjAfF524hFz6N7BEFaTLhtc4p3kk1HNDr9OU3uMA/u6
 Q+4f1gU2n9DRebS8sJ31H/n4dl8cpGeQ1wVRjUCHury7Cc9Y3umuOcA7gTPO6E+hhJbcN
 4kqgN//fgBacpSKlT15xXXzdBFCvD8jwBZ8Z4s/uTtR9SRiCx867U6gpAI8i8eConuzW7
 9GbOxb9VN9E3di7xCBlZLOlnUjKxhBAjfaCOnC990y92QLsw5SISP9CFLNvaosjASjprJ
 VKl8K5G3ZvgNqi60YFkxvNeKRAEMI2siFAmaxTxCo0NI1G7PqK3lXsFKvm9RfJxlBnw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=CAzpHI5N; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=CAzpHI5N
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4040140545
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 04:31:16 +0000 (UTC)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1B52D3F2D6
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 04:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791865873;
 bh=RG+2pAW6gYFrX+/VYNtPrm2PQmFJqmGj3nOw0IS4h0s=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=CAzpHI5NonNjZ48W7yerWsH8U2imzbeVnEYf9UW3Rx0VYcHjH1908mebIsBnVAImp
 0FVeVe0FL7woukklKWOCved8FUgfa14jY0haoh7oSwv6m6a9PoRNeyFVd+yrpPFgoI
 wfNVj3AfMjnNgb7r4ZuJJ6Jcvs56qJv/itflcklCu5cu0F15523E/wZ/HnJq+oJhJy
 m0Va6hJIRYTAtOBe62KPkDrfli+RMdCwaqzeIvqridZBl34OES1MihCR24u0GhDhqy
 I4IxOr3OaJKzHdhQoijdkYOg3yD1zfXm/WxqenPRmmSS0ofi/PcGtitefeRO9/1SxR
 HjteYq6+2gxY9Fn3Srp8CLx55KtxCy+/osMyX9mseEiGlxx3iNtp0cGJoOdkpuRs4z
 ZoZzHY7chZvmbCJZf8vuU6dbGWwq8zZ1h3Og0jxbYVxQqTz0Qa7Tset7phICmp2lg0
 GszR/3EX/lta1LdnPzASW1SfREhykcy91xLZNEqbZb5T5aBQ7mBDtIHFBWPupG5ePi
 +P+un1ZJbeJvKAP+4WRn/lM0ohjfhPtgMA+X+VWaChdqgCnVC4XfWITvtwdnXwFGyG
 Dl5hwxoRHuC63LlHi/mDnKU3DDCs0fFaKGTkwDLZHdEn8wTHxvl9X4z65qz43JvAA6
 YvNoatmzck437tH4u4cPCwDU=
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-89a4e8287b0so566940b3a.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 21:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791865871; x=1792470671;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RG+2pAW6gYFrX+/VYNtPrm2PQmFJqmGj3nOw0IS4h0s=;
 b=TRgUTaQms9LsUHf91GaU+hkUyI2fv3qIoNA3vUJ4/FtZUqKIbshucbjXa8K6Iy3Sjt
 nGKszWI3TkOPLqbuxRLga+tnUnThPlCMHIoKr4mK5hJNYZjehR55eaqXyR7v+rcnxZn7
 2oUj9m4z6kWrRZW5pb0v+dlt7H5uQiHGSS0H+TYq+tSLg5lGJiccftvkBtLzQqgtV/mZ
 KLRWby7NxRTe004jzWZasDDQsSRwwCyUhG9/JfDkWB5wAlC+kiY3I4+ISpQU80un4HSl
 IHSXmVWHMV14m/U2chY9Y9wMLiEaY0T+JqnMr4oMqajpvYZpmEWpbtvjdEeWOP+/R8/R
 ZgYw==
X-Gm-Message-State: AFq9FYJt1sMRBMLgOdhtce0YAKbonSTxHep2X2p+ILjK0TIdd3eetfBn
 vi/GpHlkRr7vYhe1m6mC+vP5PHg9GsxniJEn9qRSK8Q4RuTPHd/ugQQtil26yr4NxlY4NZdH2pO
 Z7BOsxJWP4VFq7QTJGIlbPPlLM4JknmLC0OFtnWVeGzuXkYfoGkEddoA4YS0lCUP5ltTP+IyBUX
 LnnAlcmZXVJwMPySLkWw==
X-Gm-Gg: AYBFou3fyBjF06Oipcq7yY0sexSyw+ezuR+wRtcjDYisR+PPyt+JSOVtymK2d+Bz9Bo
 bS9/RxiForGLO7gUxmDee4Sl43yv+/rM1JQ6mFQmTSt/cLsBYlqX1yPKSj02UJtBIbiYxTbXvTF
 4T9v9m+XoCWAMUr8qH4RHCxIFFphe4jETSWq0EHoLqU2C4F/BkKgcVBVHyIvie1XrzCGfKxoUJt
 8QCy2XOxIrHtKQ6SS2CMKjDw9UTngB+suK8dUWU/zqCIARG0YUoiM7ZBbCMsJgJnH2C0J6Uzagt
 vHWVAoz7x2ksmBVgnpHJf1gOGGWGEr5VRw6ZZkNGbHQngjBl6VdmYGVY9Yb21ynKt+dVabH2z6D
 vo84eHtUnytmHwmX5wfZEzP2CiTpmKP7GfNaOddb1HFhxjFE=
X-Received: by 2002:a05:6a00:3cca:b0:892:66a1:a175 with SMTP id
 d2e1a72fcca58-897c7fbecc9mr9119056b3a.52.1791865871272; 
 Mon, 12 Oct 2026 21:31:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:3cca:b0:892:66a1:a175 with SMTP id
 d2e1a72fcca58-897c7fbecc9mr9119041b3a.52.1791865870869; 
 Mon, 12 Oct 2026 21:31:10 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-899b738d03bsm2419931b3a.41.2026.10.12.21.31.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 21:31:09 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 0/2] imx8mm/n_evk: Drop duplicate prepare_mcore
Date: Tue, 13 Oct 2026 04:29:40 +0000
Message-ID: <20261013043050.386025-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 13 Oct 2026 05:47:40 +0000
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

imx8mm_evk.env and imx8mn_evk.env each define prepare_mcore twice.
scripts/env2string.awk keeps only the last definition of a variable, so
the duplicate never shows up in the built environment. On imx8mm_evk
the last definition is the i.MX8MN one, which sets mcore_clk to
clk-imx8mn.mcore_booted instead of clk-imx8mm.mcore_booted; patch 1
drops it. On imx8mn_evk both definitions run the same command, so
patch 2 is only a cleanup.

The default environment (make u-boot-initial-env) of imx8mm_evk,
imx8mm_evk_fspi, imx8mn_evk and imx8mn_ddr4_evk changes only in
prepare_mcore. No other NXP board has a duplicate variable in its .env
file.

Aristo Chen (2):
  imx8mm_evk: Drop duplicate prepare_mcore
  imx8mn_evk: Drop duplicate prepare_mcore

 board/nxp/imx8mm_evk/imx8mm_evk.env | 1 -
 board/nxp/imx8mn_evk/imx8mn_evk.env | 1 -
 2 files changed, 2 deletions(-)

-- 
2.43.0

