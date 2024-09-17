Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569FDC35FFF
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 12:34:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7344C88E46;
	Tue, 17 Sep 2024 14:34:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pu3Uvv5p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DAEF88E64; Tue, 17 Sep 2024 14:34:53 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5B2588E08
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 14:34:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-374c4d4f219so3644018f8f.1
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 05:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726576490; x=1727181290; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YfrbN8vASUjkWF2dEM56z/vKD6459G2JSploWPqdNow=;
 b=pu3Uvv5pff6box3b57vt3kW/14JqkDebzFk5gi4T3fW49u0kVjIoos+RkL7bgkRt0s
 mL9SGeOH81hiVh/zRIVfgszVZA8X23GE5FRJR/Hh3i9DCSbB57HIpzv+Dlmnub32kmZ+
 ajjfNiq9Sdpz4c0yKlhzz0eI+FKQL+tWWE7vg77+kAYHygU+t4MyLHDvKidzbie6WkcP
 u2Xu8wWsg8aAStjNWrvtrS9g/HQg99JZ0GiM2E9UeZ35mVHaWaTDwKjzI+lMmfLIbTdd
 IOWwBbLleHsVHKVhPF5CUXUClWf1BAwBWfcjay1UOSMc838CEybxU3Dv9EjWDRc/tU2+
 1ESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726576490; x=1727181290;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YfrbN8vASUjkWF2dEM56z/vKD6459G2JSploWPqdNow=;
 b=MfMBMUFQzfW+l00iVO/ERv4cLXhh//hdE9tDhpz8wgpbImq/KVcR5psqywcmFOMHul
 geNxGwyAVZ/xoct9VOjjzk5ydF5Bb+U9MpatgC1tXhX1ZNMgyosFR3I5JHxK5U+zXoPY
 zZ/KDybV+neEhmM9PaocrupEfQOMY3ZMvVRRtgrj5vejMODPvAfjSPdWVgRdZiio1Cmi
 BIWt3mtoyfjqWyFt8iI39wJyutu8wDPusJ6MayDDcQkUJMPBBILoqtde/tIKBof1bwNW
 qw5oiOKEZVnjpDR0DWNV1cfXQFuY4UyY5ek6E2Q+74nB6simyKxFSoznCHClFwfrJ8mQ
 mFHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0HBEVMpTaSSG4aEpBB2BgvboqpIpW8yU4KXLhkrRjbkoEtfTOpuNc7Rlv6kN99uAt2BVBFkk=@lists.denx.de
X-Gm-Message-State: AOJu0YxGoKFXG4WnSKnJ/PFsbVbHjegI5UlrqtXq4Y+1HW9F/n05htN8
 7T7ITMdyip6fIJlc5AVkYZK0eDYkbKvxYvW5vRbvniLCayc5NwRzrHHbJhTchOA=
X-Google-Smtp-Source: AGHT+IFMuFng77D/cZfPmSyNuXa4G6MQpGK+33/1CywKPuvq1zJ4rvZBzvFxj8y+bzKRVxl+9xttYA==
X-Received: by 2002:a5d:6189:0:b0:36b:a2bb:b374 with SMTP id
 ffacd0b85a97d-378c2d61762mr10938211f8f.52.1726576489865; 
 Tue, 17 Sep 2024 05:34:49 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e73e80eesm9381772f8f.30.2024.09.17.05.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 05:34:48 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/2] ARM: meson: libretech-ac: add support for EFI
 Capsules Update
Date: Tue, 17 Sep 2024 14:34:44 +0200
Message-Id: <20240917-u-boot-topic-dynamic-uuid-v2-0-416e39c6e271@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGR36WYC/42NTQ6CMBCFr0Jm7Zi2lh9deQ/DokKBSbRDWkokp
 He3cgJXL99L3vd2CNaTDXArdvB2pUDsMqhTAd1k3GiR+syghNLiKiuM+GRecOGZOuw3Z945Y6Q
 eTVPLTpXqUhkNeT97O9DncD/azBOFhf12XK3y1/5jXSUKrK0edFNqZcRwf5Ezns/sR2hTSl9Sz
 lFlwwAAAA==
To: Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Da Xue <da@libre.computer>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1318;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=vGG/LVK+m0FKjCCckEJIYd6d4ixfOd/bhBYuFa9jBc8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm6XdnllfzrUrSFt71eboFPj1eTHUNlvc5s1Co3mdU
 KaftkZWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZul3ZwAKCRB33NvayMhJ0TCVD/
 0bFw5XlwQUj76AAHTZlRUaVEcbpdRZ1FJ9+hgscBU6f+NTNcukEta3/umLaiNjssM3LBp6zB6XCCN7
 7v0gIBEX6HJ4OO/rJQOkZmEZoP9oo8CHuZ6nNBZp5XwzgFxV1/TfBL5OJl9jrhKi5zlhiTR3WRClMh
 2OTI2g0ysv31FDtGsjMjnFzWapYU4eSZuSPK3igGZ5u8BBi84aItPuiYHtPTefUZcXhltZi57WASIk
 Ld6sFDR4qGvLQM8XIBDfEmBZ4/68TJGLD4JWiWUmgx8Y6sBAWpvmfQ/vA9CifTHS9g4maTO4bvP92A
 WR21WBpcFygva2OoGGm/P9IRMOq7AB4PTvOCOZiRYLnfLZD5/KI28wR2WGvQwoWezkTtmLrAntDnC6
 +qq7IlpuIGQAkZrjDM8hUB2T12DGJjx3WJLbFbNaniGDm0XUEhnceSUf7/B3uZDzxfWVEW2i07hAnS
 oQS5eMgvh4DCIJQCTbJEXzHMWxvQlq+GDzH9gvulBf9WMEzeveZFL1HVO97csSrKN2iHbm/YHTo69I
 lVGlpv+Zz9qGY8iDiOVTwQMA9oZ75PFkMvYENjjQVW/DDg73jYQRNQrMAOXIXX84vm0+/sH/mQ5J9D
 5ELL2QTXKqdmNmpDXzrxFv2uk35hM65JwX1ztyDdx8quiMNsZ4DIaAlIc/Xg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The necessary changes were made in U-Boot to easily support
EFI Capsules Update and be compliant with Arm SystemReady IR.

Let's add support for the libretech-ac/AML-S805X-CC since
it's an easy well-supported target having a dedicated SPI
Flash to store U-Boot.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Add set_dfu_alt_info() + CONFIG_SET_DFU_ALT_INFO to support both RAM and SF DFU backend
- Fix typo in cover letter and commit message
- Link to v1: https://lore.kernel.org/r/20240916-u-boot-topic-dynamic-uuid-v1-0-7e4f48542a0f@linaro.org

---
Neil Armstrong (2):
      board: libretech-ac: move board support into dedicated directory
      board: libre-computer: aml-s805x-cc: Enable capsule updates

 board/amlogic/p212/MAINTAINERS                   |  2 -
 board/libre-computer/aml-s805x-ac/MAINTAINERS    |  8 +++
 board/libre-computer/aml-s805x-ac/Makefile       |  6 ++
 board/libre-computer/aml-s805x-ac/aml-s805x-ac.c | 71 ++++++++++++++++++++++++
 configs/libretech-ac_defconfig                   |  8 +++
 5 files changed, 93 insertions(+), 2 deletions(-)
---
base-commit: df84c019c46e6833cc79385bdb23efba4882c09d
change-id: 20240916-u-boot-topic-dynamic-uuid-a871c25236a4

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

