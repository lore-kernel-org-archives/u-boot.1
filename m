Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C61B606B2EE
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 21:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FB9+3ZwZ;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=cQ3JMA6l
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D7C9640968;
	Wed,  4 Nov 2026 21:23:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TL15GXKliGXS; Wed,  4 Nov 2026 21:23:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 02E8A40963
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793827418;
	b=irfGdsHg6OMJnzwJfteA7IzLOKR8xAm53JWPnywYImBv92izRvneNitietM4qVIC8EfX
	 2wibipzvE/cXr/jPxuoZHQRc4A5rgEF/4U2vjUVZcVukLCLPvqA4eN7dBZvYW8gh18HjZ
	 zr8ybVcEhPswkhCB5C9OSVfL9N/UUsfk0sXKbEUS0yiZeT9kNUX246sSXyPQYp7a4FI3F
	 WX12m16+LRpweO6RijUMMF4+DZR7b2RuSleFX7xkihwbwTeRMRCIWqrzZ6t0J8qiqgths
	 scn09fJbdQsdeMkf8YDMBMEA5OJf33Jfza1Tqs9MMfXcM8TvxiiZ2159JjAvNZwB1XA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793827418;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=dTU60/WZ+hB+QMDf4E6Tl4qLFkfdlcDPhzMBAoM8xvM=;
	b=NtqF7RLTcFw9kCgklSSyk2OaMY6PhM1zh6aQ/ufUiBV/7zA2J526jHhnWmgyw+qljOq4
	 tsncoY4479tVNKrjwSNfzrtyiycb9FIJGkE3cTY3kvhIEbsNYHltSVjWWJSKc0iR9nHbn
	 PJp9oUpnv0ZPmgs2qQt+TTZ18iG+lY/gBawJyLWM2NYrTPar6wkujQP5Io6SbRRwtE02+
	 VgyQnf1US+dwDKsMg4lKhhFvzkNNtnBfN7KxHRZHwShdT548uLZTF8KhBpkts4oKxZkwE
	 8wnNyTrRFlXh/WWLtrB0Rat+jsS1CotJxaw5QOiEBEFs62OJ4iNMn+R1HSOgjP0YftA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793827418;
	bh=dTU60/WZ+hB+QMDf4E6Tl4qLFkfdlcDPhzMBAoM8xvM=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FB9+3ZwZCznnPmXL3EWS1LnwQTxxTUqfcQ0qtJbX+rfo2ChzTN2a4kL7qsjEx5j4/
	 DtlLwkkUVFGlMJb+MqA/yYDsDazjLXGe+qG0HgEZNtU+V7bML2m0Zhw3iQPc2sEtyg
	 Hux/3wJjS/g0jdTTxIGMzOsYSW6IujEsIrmSwG2g1X3JwqsWmc76ygbWqQiLxZOueH
	 9oeeI/pzYhDXhsomtLpaFRoVIR06XqijrIutE2Nq0zd8aSPMRapw5DN7ruRJSNnHgh
	 cIIRW0fV5jrU4Q3I/7e2pkHFIQJtOkLXYb64Ci4k7stjWr9RunI3i89ZZoTpDs23//
	 oCvTTo6fEPqyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02E8A40963;
	Wed,  4 Nov 2026 21:23:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 887AB362
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 21:23:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7A4C581271
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 21:23:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lrGOUZnC5_sW for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 21:23:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 080F88126A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2e; helo=mail-oo1-xc2e.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=cQ3JMA6l
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 080F88126A
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 21:23:34 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6df0b02fe91so26515eaf.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 13:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793827413; x=1794432213;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dTU60/WZ+hB+QMDf4E6Tl4qLFkfdlcDPhzMBAoM8xvM=;
 b=cQ3JMA6lZ1UuqyyrJ97NMZzV2xaQAubrJgh26QlxEFCUu/BfLZjrTlNYwwD+dCmGx9
 Wdv11lwRJycyxAE10wFM4T8yf21ssG2r4EcsRvKC0nwKMzX+khbBlBch2qn8oMAZuByp
 6w6VOMJqxfULxyq06bbyQFBLQIk9tutJkFdLLI5UJ4zmES5pzDQmclpu5a6M59BJgQOS
 VejC9sDKJvTcQdq2aS4bgiXlKVHC7713Fu7gCDc+WWYdP9M1fqLEo4q5bco147yse5km
 32yD64bIoKu2HEK8OooZ19SHuFiUhz0Gx0X5ZS7Lmx8kjVlYEsdPtoSshgbiOywbPCFd
 7L+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793827413; x=1794432213;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dTU60/WZ+hB+QMDf4E6Tl4qLFkfdlcDPhzMBAoM8xvM=;
 b=huKGAll17+A08kKqVPS1S8VwItBID9qabfOcZYWy7zvSv9GC5ZEWgoUqx+Plc2K3kj
 1V+yWOhwFFHkp+o73qbuvKHR3vVgUotriLcJvXpL56YnQMI+axYkYfheBKbMUFaR999G
 gNvr3NM5yspP6uVrFwP88bYhtcTKlxMapgdnhIYdOg0IRr09qn+CQHnEkYsi53KsVjPQ
 lmv2QNLOR2baTOIZ+ZulAPsXqVA/SB2WOwdij92sBc2dpvJnmy9YXhjO9ydJd6HGhGAe
 cW/EuBIYMmcQqwPSRSAXsIpel9z1pLUbh3sJURokfmLz0bVaJFq+Oh2EEEXWBfmDpRZa
 C/fQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzp3TYtJmPo4Z2zTaXeHOyjeHUZm/ysxZBOSX4Rnz7Jyrdd8CXFdjKvOfTKM4jp2ozqDk39BG0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/nIZJiNlYPvE848yBL2DO/OnPIGdZivx+AnrIxRKqdBfKiBYDO
 CBP19LhHABE+ZlFeOnPZus4QR+XY+YLTeG7Mf+BaHG7+3EnGcSiNKdK3owlOmnkkyH8=
X-Gm-Gg: AYBFou1JrWU7FQvFCsS4NOYih0xThZnYOiSEKhGERJbaIDkRTe2C7yULD8driOsCjEA
 lRnwONe6KkmWhYjmVKUDGHE5AY2yX3we2Tyg5BLgsrelaDf4Ft1EzHi0Qq5WBgVQpfUAVcAN72Q
 IiBelqAPeZRvHPp9R/zzFWW3dXRfkU0AZOrnnOdv6xCnHthCIRUnrWOpKWOKtpmGPTQzaljBmTA
 zh/7kevUtpuEffyAJvS/J4xChwsLQucYiUWIWrqhM+0Ij6uXRJgoOgB2m/7GfWggu2pJGM58Bq6
 3syeesIP9A1trguo5ZqAFbY8lQmH3fxkLFKJsc/YvGHsyqHSco95puRwOEEeqiCn+YBlMfznBe1
 1laaBCJR6n363w1IhQkdbBsXbzIMvlNsIrRZZFsE0eMkv70KSv3eHEas9gEC/6p6Qp5fbCkk8tE
 ALHzhdTs47HKl1U1SQ8yVTIAatsFU4Wum56QRGS8nNdE/0SKipwqAw3JCx0VhJr7hVaehti1XCC
 JRSaPope5rzRNZ0rVmcZT4+YzXMxoFQ1eYbkboXDA4Kd/MwvF3Bhp/SxXNg2yzB22VGZPmM2aDo
 Rg5ic0dMiUbFLUo5Q8hq4vFDgYH2ORU7
X-Received: by 2002:a05:6820:81c7:b0:6f5:a844:b12 with SMTP id
 006d021491bc7-716d22ae516mr452791eaf.57.1793827413296; 
 Wed, 04 Nov 2026 13:23:33 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f563:d5d:661c:51ed])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4ad6840797dsm845548fac.9.2026.11.04.13.23.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 13:23:32 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/2] bloblist: fixes for transfer lists from TF-A v2.15
Date: Wed, 04 Nov 2026 15:23:07 -0600
Message-Id: <20261104-bloblist-tl-fixes-v1-0-477121908257@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQqEMAwAvyI5b8CqKO5XZA+2Ro0UlaaKIP7dr
 B6HYeYEocAk8E1OCLSz8DIrmE8CbmzngZA7ZcjSrDQmLdD6xXqWiNFjzwcJFqSqavO6diVotwZ
 6hGbN72XZ7EQu/kdwXTfrWcG1dQAAAA==
X-Change-ID: 20261104-bloblist-tl-fixes-4e2617a399c6
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Raymond Mao <raymondmaoca@gmail.com>, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>, 
 Carlo Caione <ccaione@baylibre.com>, Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1081; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=1guNVjh3zpAqyTHKLFegZjQWMfkljdzwclcJNDB+3so=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq66I9JY2euVOF5G/ecm0oQznoRgy4ks7bd8RGE
 VZA+jQjoD2JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCauuiPRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AXKAH/A2kk567MuWLAsQ2nZJGq1IMC7UTl0Gy0hH7UFW
 iWbGtp+oToJZwWXkUcuiDXMF8xrf4NwZXwJ57Pq8lK1cY4e0LXsWNP3zTzHykjsDlx5+GyeHU+F
 UCoOXRPCCTO3dSAKz8iuzTB5SKrUt12ZadJ71tYm0HQ6dX4F3oun/aAiZSDxAYAEuvhAYNfkVNL
 15kGZajYwTFytAImc8Isn2WpCy+Ahzaws36mMcN/9CL08EjLjWYeGK2TmKPa13pQLHbo2rASmaE
 dynz0h4OuXFfduTAw6A7nuLlynofGrrC0WMsUxS+/QioEhOARcKdMSRE8dkgrVkmB584iPF6RU4
 tznQ=
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
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

U-Boot cannot use a transfer list created by the transfer list library
that TF-A v2.15 and later use. The first patch fixes a hang when adding a
record to such a list, the second moves to header version 2.

I found these with a DDR loader for the MediaTek Genio 720 EVK built on
TF-A v2.15, which passes a devicetree overlay to U-Boot SPL in a
transfer list. With both patches, U-Boot proper applies the overlay.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (2):
      bloblist: align the used size before adding a record
      bloblist: move to version 2 of the transfer list header

 common/bloblist.c      | 16 +++++++++++++++-
 include/bloblist.h     |  8 ++++++--
 test/common/bloblist.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 66 insertions(+), 4 deletions(-)
---
base-commit: ca397fed3948483c4708054d3e73a51962f2b27c
base-tree: https://git.u-boot-project.org/u-boot/u-boot.git main
change-id: 20261104-bloblist-tl-fixes-4e2617a399c6

Best regards,
--  
David Lechner <dlechner@baylibre.com>

