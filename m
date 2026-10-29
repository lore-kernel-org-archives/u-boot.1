Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E158606A321
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 22:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dhp1xY/B;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hH/A5Zo+
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D01AB8108E;
	Thu, 29 Oct 2026 22:16:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id skysvjOdlUDg; Thu, 29 Oct 2026 22:16:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C2B6B81082
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793312164;
	b=apuWJOshxQj8sMwpNmMsrGEmQExcGtcaRP+E8JXFvt3MpqIIWX0MOl9WxcmR7mNIZ+ce
	 46ea65MDSCEkHdqShwu4VXIg7cQZOqsqkWBqAuJM8+6UxcwrdTX7M0R7KhSbaeQJpT/tJ
	 GckX2It9rwjtSNL4T5pJrioWhv4NbAXMkZl4wVJwXJ5gp4nKHY0v5688/VXNJ/1z514pK
	 w45oPhxfzvesri1mM47QtOSZvtnFyr5CUUU5ZKhBKZJLJGwBL0siCRqJ9qc1Qp/DzvTfz
	 fjjSGRlTXKKj8eMGIBdhR1ri7NEIS4f/6HGVMd/bOKAQqAJbeUjPY+CnVzZmP/iWbSg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793312164;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Sender:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=9KW9tXsZ4+U7zsubImrx+LUOYnjeEaiph+cqEtdgCAE=;
	b=pVN7l0c/5rr4A6X46vCLhexwPBfFaRm12W2b20bzW6ho3JdJbtH/w/7K0BAovscolntm
	 OvxA+jXthc3vh3JInXPL502ucDHPbfoWu3vnkeneRShTR2ceyczwtQxNoPTdYP7xCa2Wj
	 H221oovifTcDSDb8EHymUAMKYO2Ntqm9nOqCFqLt6KhupS2QZGAGbg8LGVygryZyoSRiP
	 4SNNZiIqeIkcM9wtmKMDEzsyQ/qiQrbZg5Vrv69IQCOlJJU1dMjS/gmmsAFFnHd06LjA+
	 Fm9AON5+VBj4t37OQRnq9Ua4RfbQ+PYGnSskWNnAWUxcR6ZJANm4IFiW4Hz2M0RgUJw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793312163;
	bh=9KW9tXsZ4+U7zsubImrx+LUOYnjeEaiph+cqEtdgCAE=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dhp1xY/BiikdRWMNlZXh+OgCpxAlg3HM5avCn1U1eceBcbuRlrk3bw/QdR1baas2p
	 Ik1Pok22v2bkbOdSJRSNj0pqHX1jLle8zDpKwRkaEci3M9LWUKSfWbpQbWvp9c9GEB
	 zVsXpUgw2+Yh3TWBlw6XGdCdMukaEVuHhpkj7sNBCxsiCly+aPU3T2v9H5/e1hpqjH
	 XDHIrrCzyga7sLv/Bt7Cu9Nzq03PurPrdzklsYep/r3RY9Ia2KiWenZIyQwzXQ1ztU
	 bmZUXKiB9bPCIIJFlnXSb1DF5VXjiZgRFqos7FG3Hs9448cnR5sV/LhNKQj3wZjhM/
	 EiDKqiNWBPUNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C2B6B81082;
	Thu, 29 Oct 2026 22:16:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0F97E2E5
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 22:16:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E795B4050C
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 22:16:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AG1LZMNXDslc for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 22:16:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CBB1D40176
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793312162;
 b=FnNxByhvCfqS42Pq271ZYocJjt9jkNlqeU0M4+UKP0sA9qtbyI5jzXtMEjFDuNs6jWAb
 FVW1rY1Ru14m9vFWFoTiVJW2Ks82AtG7M10Z8faekFu1c63vipQR8MIS48wTy3OchlxQz
 RsNINeaS+8D68VAQY0zw/AM2fIymBFOMcaLAljbgfM2XXX4OwC14qzA3ntUU94bCtI6IZ
 s/o+D99WlEqg73QFfi1Vfje28tFVW7xEZLIUaurygutaIcO25utgdiLTsdRubPjqHObUj
 PDxT/+GFhYfcrNgoFUidhSfxHbx7bUR7Gvub3EAX42kvmEp+ad4i/NJrwcE7F71HSnw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793312162;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:Subject:
 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=9KW9tXsZ4+U7zsubImrx+LUOYnjeEaiph+cqEtdgCAE=;
 b=IlOtnntAzKMC1IjNVNXS3446/L2QTAksgM6OJpgD8g+sngLsAUhqkRSZdMMTCOqF9Y/a
 gpD+N1Usp0RfUy0M1XbIjvhq3uF2bzfTC0Ee+x6XVuvgB0OtcwJmi1TnhZmIeBp5Zwyoe
 zrCNWHBjHF1uxguBXssq0F7WypHE852wl9MzHX0ae1fwR6h5ENRmzGTlKsDTGKiNNeIgG
 WfpB9z6FsdD+wrCMGMy7j9cDtQnPs/5jcIQMt1C34yKBRzK0y6xE95w/DXZpJWn9SXs11
 xpIkt2Hk8xBcXkby1gTnT4qHRmnGvjUTY6n+gyUj+JNdmX/JyRJPDbml7VebH2lo6IQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b="hH/A5Zo+"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=hH/A5Zo+
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CBB1D40176
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 22:16:00 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a20bdaf39cso512835e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793312158; x=1793916958;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9KW9tXsZ4+U7zsubImrx+LUOYnjeEaiph+cqEtdgCAE=;
 b=hH/A5Zo+8IeERBESsKPe8XzyLPGBoCfr0b2fMqJM4imNpheRs9K9q5IsCP7TXO8kYF
 A9MLkE1RDgK26fXuw9UgyIIswkuHwDmGZ9N0vql0CPcSSdonyszjcglv3j5H1Vwd2wwQ
 2ZYQyhSA4SF5wndxJrx58D2Ir6GZ5FDDugL2TxB3V8nLhY8Quq3RMsiCwk/jW8jH8y75
 hwqq5HserMWeAZpJn6U4wAGtOU2TH9Vf/msy5t7p76EB0majjJQCweTBu0xsfyIL1hHp
 E5Onl4GHHuSEWDHZRS7g/5w+BZqpCgT9eYj9M9tE7F0BMpdJRsFdRWsrdubS9O4sFHhZ
 vmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793312158; x=1793916958;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:sender:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9KW9tXsZ4+U7zsubImrx+LUOYnjeEaiph+cqEtdgCAE=;
 b=wHSqpfMKHKWF1HKJ/4tVcscRldRlvoQNdESlLcyr1UzflX0tmSmLRACuLwlPRaRdmb
 aWnT1fz/ZhnSHRrTNp7ocJtJFZDDVARXSwPmYzSPY0oajSbKUStg4AH+p24pHV+GNCpw
 90GK6yXXsrvi53gq31YZkUr96OV8f92tWsW0akgiN3oTga4xcBGaynB+p+DaK5Wz6OpD
 HViTfYjXfLxYU4f5/iLMEPmlY3e/D8yjYhLD/Rle2yCFm3nKzJReD2PKZ36v8EAJCMwC
 CpmBUT+6qDC2WowjdlnTOLb8FHpG+EIbVdhDQR/HML4ZspFGLTfYzyjjli9UIOtA/5FF
 znfw==
X-Gm-Message-State: AFq9FYLE0tOBEjVtRYQCNv3fIaAgz18z1MhxTEUsAOV1OzxJQ4IAJyXL
 k9N+tzvYMy4bzjNK4s98eAbFqdt0aItc4HD7RWWqY1w4ZZgXycPGgwjh
X-Gm-Gg: AYBFou0Z1qJ3p0gpKaNvE4FI/Dk1Fmo4JW9yuZtB5FXubZgdpWkwNefLgSuAbJRiTlJ
 Y7+adiyI8dW9ExxPlsiiLLGigjZKf/gVWo+0sUy+37b9oNsNveuo2f+Pv26riLxMcaM1hYrbZys
 8xlWonso8WDdfbJD4EqpT7hVI++1GCgx0fQWlx+/c3KfXeH3qEr64GLPycSBfW/Ykk2AGoo9y/D
 k2DWCdZfRdkd0Z0kb4LIF66VI4ewpqyQaDtAq84G26LQ5jhwujqXG4YZpjW4DsFygO7X/aaGio0
 zJ3Ruzw1iNXcNRA3zqDDkG9a8tUta6JoKamajW7ZKskYCj1t6r6yHJbdE5YoTBv+y1QoE8r1Oyb
 KAgIvls6OkexvOadrISlXZ244M024wWQdZWoWsBhWSRHsOqLma5zPXpaJgBksgQiVc7qcA8XstV
 4uibf1OqDsBj/mNx0fygW3VSEPdkmYtY/EX5ONrwyOVkDBbSfslIGZ90Di5tKTfeeJApdBQfP/e
 LvvQjudJ0igzl1VvLT+eOXXkp2hYdzVAMoeGpUsbH7/c+jv+SjMQpem55y4mRiLqDRXXIiVgjjN
 gl5BbpPWu5KFadeuG9w3UigiIMAWZ5ZP9/xmNPMI
X-Received: by 2002:a05:600c:a00d:b0:4a1:83f0:7c91 with SMTP id
 5b1f17b1804b1-4ac185bc336mr7167055e9.18.1793312158577; 
 Thu, 29 Oct 2026 15:15:58 -0700 (PDT)
Received: from [127.0.1.1] ([151.71.167.228]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e712b90a3sm53145f8f.19.2026.10.29.15.15.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 15:15:58 -0700 (PDT)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Subject: [PATCH v2 0/2] Update branch and URL references in the documentation
Date: Thu, 29 Oct 2026 23:15:55 +0100
Message-Id: <20261029-master-main-v2-0-5c2c579e9eb1@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJvF42oC/22Nyw7CIBBFf6WZtRigthhX/ofpgsfYjrGPABJN0
 38X6tbV5Nzce2aFgJ4wwKVawWOiQPOUQR4qsIOeemTkMoPkshVcnNmoQ0SfD03McK2t5qqtlYS
 8WDze6b3bbt2Pw8s80MaiKI2BQpz9Z3+XROn9NyfBOEOuTk3jZC2Nu/Y5fx7tPEK3bdsXQOsJv
 bgAAAA=
X-Change-ID: 20261018-master-main-b0aaca076372
To: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz <u-boot@0leil.net>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace master with main as name of the primary branch.
Replace previous U-Boot git repo URL at DENX with current one.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
Changes in v2:
- patch-1: highlight main and next branch names (Quentin)
- patch-1: remove spurious added word "one" (Quentin)
- patch-2: collect Quentin Reviewed-by tag
- Link to v1: https://patch.msgid.link/20261018-master-main-v1-0-e07455d232bd@gmail.com

To: u-boot@lists.u-boot-project.org
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Quentin Schulz <u-boot@0leil.net>

---
Massimo Pegorer (2):
      doc: Replace master with main as primary branch name
      global: Update references to U-Boot git repo URL

 board/rockchip/evb_rk3229/README |  2 +-
 doc/CONTRIBUTE.rst               | 10 +++++-----
 doc/develop/sending_patches.rst  | 10 +++++-----
 tools/buildman/buildman.rst      | 10 +++++-----
 4 files changed, 16 insertions(+), 16 deletions(-)
---
base-commit: 03e45557e1f38a39a0c80fe30483130ff376cf92
change-id: 20261018-master-main-b0aaca076372

Best regards,
--  
Massimo Pegorer <massimo.pegorer+oss@gmail.com>

