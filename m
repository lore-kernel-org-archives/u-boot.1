Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B903C982FF
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 12:47:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1FCAF40783;
	Tue, 22 Sep 2026 12:47:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C4tZF-lpq3WE; Tue, 22 Sep 2026 12:47:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7BCB8407E6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790081260;
	b=fQdU1aJqYTVcxjt/nbEq9ROpmbnwVi7byMFTMoKnot3vbzsX2wqymhx5P5s3DsDWgcZk
	 1u4gbXtAui/QgpYWZwnh1BISRtdTXQIK5ceMsiGd38PR1UQmLAeueLw9v/i+AYaNYcjhi
	 Zjt67dz13LRkw4vGKR499ow9BtMgbZ+LVLE0bL3zd2VvfdnYGh6Ynyj6UdYfT4WfmeRDW
	 ejuZ/0E5SL6c2u8gPWCFVAW375PNBa81JXj2GKBO97C8f5Yh0kiYL1HPwtbIhCyJvcoHQ
	 Q771yqMzdTbchVvvSpC+VhfC5xgHQwpWl5phNWu/a+yQLw6NO4f0kV+9luTkqe/QNTA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790081260;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hqmMJ2ZxWX4aG6OJo3GAMk6gWaWPY1gJIDV1dLUhy88=;
	b=dTNX9E9/BiG4a01TTsmwlOwGdVfPQc8Bi1FOb7XrDXIc/vl8h31V9kNZc49t0I3RJr7n
	 4Fd3rFyfGlaAlWyLskITW8aAN6J5JtN3lYN1hfgfwvChqN1d+ANEjVh/LjOIiKo3qBEsb
	 Q20xHrX95vAz6YDWc1NBRahOpxO9Wfa9/K42DaqAP76aID+3hfpGfNJUXHB8lHT0FsCFP
	 rRNpams0K9sjssndO4s8OfqPokPEPlt1CnFGU5wwNF6nSynOl4yuMckMwZt50ePQAAzWm
	 QlujGW+Ov4mPk9dvFbNFTyG1iIflERtl19ECdqUcBNMPcUwf8WmpqTdnnrjrL0OUW/w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790081260;
	bh=hqmMJ2ZxWX4aG6OJo3GAMk6gWaWPY1gJIDV1dLUhy88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p3JuCOebLNXVU+ZPVeFMozGbJcv3fvKwI4f3xrxaAkjXYxvGlqdz1RVLbUn6PR3Kd
	 riPpxMixQQ7VFTMEIF5UYj3wGJs5D4/JvNUGdgrg+YPv6KPNRbXPSxWaHmoaH8U9Dl
	 mWRx/2J1hGbbpqniw0e1xbNO873GhSTMR1/iaTIb5PQC/PoOM5uaAgOD6o8+4JksgN
	 EQmb9F086fJnCRtzGd8Ueb2gsH4uAzwyxr2JZ0sVfEARDn7V7lMto4WCbBy+CFVuzv
	 oixo0lnmjsQjXuiojJxAeqnIMDv0lmIHfsTKfFqOqETmpCAjFTLPjQi1k2xGlOmBRM
	 QyzxovphQjIxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7BCB8407E6;
	Tue, 22 Sep 2026 12:47:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 65EBF13B
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 12:37:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4C5686072B
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 12:37:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zav4xflUYnmF for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 12:37:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 922156061D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790080626;
 b=j42ngpTVZ0ZbtX8eX5TmATpF652TN5NQprTlGLrg42Ohxv2O7g71ShNduXAtrLDvPYd0
 8zR2zELQcWgk5ioI2tS/FflR8z5Rhs2jQMdVT1vpskefqtPjVBglxhvm3iFlWstzLgryW
 is54o6zRCwX2yxEaGRXzAtejSdauxweT0q9kNImBTq2HrttlOm7UUdtxKqgj+mmYaSXjZ
 2BiDa1lRonvbI1XZCyXfSd/z/JDSCSgMSZ2/v2tWZ4LJL1NuUL0bVv3Zk5qJk1oHdV3OB
 bZVdR0GLJgJ+qois6E/NaV6mplpxUtpQLqPzlXgO1k1Kw4/U3bTn415mAybFMxkBr6g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790080626;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=hqmMJ2ZxWX4aG6OJo3GAMk6gWaWPY1gJIDV1dLUhy88=;
 b=BO00I3amLR6W2jrF1ajOqSfdgdy1jrx8URR5ljK/Vr/uC2kzfA+KdW4jsXfXOrPLykjf
 h0WXiH5OGL6q7H5TdQCH0C4rs+ekFarwaosNS0U4m9kuvm5y1QopieLD4wBi4rng53tas
 KK8Ib2E2WLjVMcPouzhZg41ov4eGaCewNtzoWW1qywKaL+y8BaTLjI7oUa7gjDz1gZ1ie
 7FQssShEcw7JNHQ4dE/4sA9/ROFAvNxZ1+veJE6IFuelfxBHAiV/B4AVg6hbx0+gdp4+B
 hwYfJHfYvrQdxIGxU1b/SxZZm0auYX1OdzlzGstoSNPf8erQjh+ikFJjGbaHAGMeO+g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=Jr0t90kh; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=Jr0t90kh
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 922156061D
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 12:37:05 +0000 (UTC)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6328F3F781
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 12:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1790080623;
 bh=hqmMJ2ZxWX4aG6OJo3GAMk6gWaWPY1gJIDV1dLUhy88=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Jr0t90khl83PfTGlEBdJlQrOLuSZvvibdQHn8+Mvonxj/KWp7pnCxpfNsWPd891Y8
 wBfapFdDdHM+DSYdXNnIpK+mK5SjTCcwk+XqI0WLtBpyqmsDfBxxJpR7EcxD7IRsvZ
 38oUMEUv+XEGGBS96nc4lXKV9RR2KhEaXg0m6sj5HTtmkv1KzovpPkzWJwrvIHNjiT
 QdMzJ+yXebUvZS2OxIWQ+lZaFj9DEVVsiHxfjKF9agD4wMEn6nzFvZGnZ2sxTwDtui
 Ghrqyp7pj/6o9dJ5p48FU7HuD964N/mUZJOyOasSTrTn4LPCKptNCD1myUSPhA1sP3
 loKDtQ9i5mVIx8s0mxMnJiLllntjM1T8I02zuBgIw5UXITUmFYks9S39pIXignh6sE
 gNcd/ajnThw54+oqTKbcBvnKw7yvmQhfG9xIN79z6p3OtB/SlMibGQylR7UjEjzah6
 o2RK0/FKCMMC7elmHbGahuqoVSLGkklwLHfe3iUVtw6/yoqnhJgJKNOKMs8Z6Su44m
 pQAgm6PlB8KxvBKtminXJU5CsmnVmIwLyPYd+LmKylNv9C6uiUucFZkdeozjkL9YbN
 12RIHy10Iid4D7Yf8KnK9pThVdlwIrI0fPRgtOQaP+i8PsntBzfxS7w6lXZwQWw2iB
 KTtHa8OXelcsB2iKmYVeNGac=
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cfc52ddc55so54926405ad.3
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 05:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790080622; x=1790685422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hqmMJ2ZxWX4aG6OJo3GAMk6gWaWPY1gJIDV1dLUhy88=;
 b=zWz/Vw+HuS3vpdMqXyvxLUdyTB2YtImJRFY9DAuoNqPkSlj3M9ut0gLi1O+Inxdcau
 YbJeZ9cZKgd3ygYt76kZTepdG4ZxJVazxPnHDpM68B1n6co0AOyVCGcSybDgZrqg6IGR
 n4kw2uyHSfiHpQzV7eFsjUfovVLCUpJpCTFoO6a/CK4RxS6RJaV8jHL7xFO7Bs/r+jcn
 sBHZmbQwFmzcbd2DXzOtZ6r4qiyW+rZCt32SbTs7mqyAH3mYwH7CaEGhynksHCuqIdLL
 cpRDWdqm3G+VTJz24fj18tKoqh56YR47hjixxz3qq7okwDCrYxt/+TbjveDnZfk0/AwD
 1Syg==
X-Gm-Message-State: AFuF++k/4JbEmAW5z/7BQy6VFz2gsdMwP/0dDRkjyXg+I03UnLItH2JX
 yjc6C/FO3rHvfhP/+MeFxz+MO/R219Qjt2pU3catg4WTdg71hZhcoEGqr4E3FPrrNIakgZu5z7O
 04o890ey7JN084TWwMLjcTn+R3CZVAkkQ3B3Dzujxw7SXEQz0VG83iDc+EVWpN5ICdPDiqUoI83
 c7OrGWUanQJBvWiYbZ9g==
X-Gm-Gg: AYBFou1VihscZoKhhUMcytwWZbQW+647vr1v/LhQ8ETmiiYAM0DZAeILAILRB/V2Zg4
 NePXX/9h3PG5w6O+UZHCQL3pumoQQ/esBS9af5640dCYhbK058nrBIU1lYDwWgVpt/Q0C1ZAOQs
 ZPyl9rlGaOhsRlvCxkhMddseG/EoxNl2d1fMUJoOtAahR7fRP1NRo4aSTutJm7jR50yErapr3cO
 0byEQ37jo8WaRuXZXj1Q0SvAnki6BNoWTEI3OwEBleYE6EKdXQt+8MKNmf6yi7/Eo6sPYKOH/A1
 2aLCtzkNO8m8P/gL/tJhSBaoT5idqdkRQirQvswwtgLeo6RoWHxCVyRT0auAzaDJnAL5vXmiA7L
 WSvvU0wkOeP3e8J2I3y8meAeeNQ2fopcPNArO0lo51aoxJR9bKls=
X-Received: by 2002:a17:902:d988:b0:2db:5052:fd6f with SMTP id
 d9443c01a7336-2df609d4f2emr12689625ad.17.1790080621462; 
 Tue, 22 Sep 2026 05:37:01 -0700 (PDT)
X-Received: by 2002:a17:902:d988:b0:2db:5052:fd6f with SMTP id
 d9443c01a7336-2df609d4f2emr12689225ad.17.1790080620855; 
 Tue, 22 Sep 2026 05:37:00 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df5d058116sm9054105ad.77.2026.09.22.05.36.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 05:37:00 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 3/7] tools: mkimage: resolve image-data references between
 FIT images
Date: Tue, 22 Sep 2026 12:36:23 +0000
Message-ID: <20260922123630.608961-4-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922123630.608961-1-aristo.chen@canonical.com>
References: <20260912124454.13578-1-aristo.chen@canonical.com>
 <20260922123630.608961-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 22 Sep 2026 12:47:32 +0000
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

An image node may carry an 'image-data' property naming another image
node under /images whose binary data it shares. This lets several
configurations load the same payload at different addresses without
storing it twice, as described in the 'Shared image data' section of
the Flat Image Tree specification [1].

Resolve the references in mkimage after any external data has been
imported: the target's data is copied into the referencing node, so the
later ciphering, hashing and signing steps see a normal image node. The
property itself is retained in the resolved FIT as a record of the
sharing relationship. When mkimage re-processes a FIT that already
contains resolved references, the node's data must match the target's
data exactly, and fit_resolve_image_data() skips its own pack and
rewrite of the file when no payload needed copying.

A reference is rejected when the target does not exist, when the target
itself carries an image-data property (chained references), when the
node's existing data disagrees with the target, or when the node mixes
image-data with external data properties. The last case is caught
before the import when compiling a source file, where the combination
cannot be legitimate; a re-processed FIT carries both on purpose, since
that is the resolved form with external data. Since encryption happens
per node, sharing encrypted data is only accepted when both nodes use
the same algorithm and key together with the same iv-name-hint or,
when neither uses a hint, the same explicit iv; anything else,
including the independent random IV generated when a node provides no
IV at all, would produce different ciphertexts.

[1] https://github.com/open-source-firmware/flat-image-tree

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---

Changes in v2:
    v2: fit_resolve_image_data() skips its own pack and rewrite when
    nothing needed resolving; reject image-data combined with a complete
    external data reference before the import when compiling a source
    file; complete the kernel-doc of the three new helpers; document why
    the remaining check runs after the import; add
    FIT_DATA_SIZE_UNCIPHERED_PROP and use the property defines

 include/image.h   |   2 +
 tools/fit_image.c | 358 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 360 insertions(+)

diff --git a/include/image.h b/include/image.h
index 4130cea0199..5248ca98d41 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1160,6 +1160,7 @@ int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
 #define FIT_CIPHER_NODENAME	"cipher"
 #define FIT_IV_HINT		"iv-name-hint"
 #define FIT_IV_PROP		"iv"
+#define FIT_DATA_SIZE_UNCIPHERED_PROP	"data-size-unciphered"
 
 /* dm-verity node */
 #define FIT_VERITY_NODENAME	"dm-verity"
@@ -1183,6 +1184,7 @@ int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
 #define FIT_DATA_POSITION_PROP	"data-position"
 #define FIT_DATA_OFFSET_PROP	"data-offset"
 #define FIT_DATA_SIZE_PROP	"data-size"
+#define FIT_IMAGE_DATA_PROP	"image-data"
 #define FIT_TIMESTAMP_PROP	"timestamp"
 #define FIT_DESC_PROP		"description"
 #define FIT_ARCH_PROP		"arch"
diff --git a/tools/fit_image.c b/tools/fit_image.c
index f7d11904472..f1c3ef3ee66 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -956,6 +956,24 @@ static int fit_import_data(struct image_tool_params *params, const char *fname)
 		int buf_ptr;
 		int len;
 
+		/*
+		 * A source file must not combine image-data with external
+		 * data properties, which the producer fills in when it
+		 * resolves the reference. A resolved FIT legitimately carries
+		 * both, so this only applies when compiling a source file.
+		 */
+		if (params->datafile &&
+		    fdt_getprop(fdt, node, FIT_IMAGE_DATA_PROP, NULL) &&
+		    (fdt_getprop(fdt, node, FIT_DATA_OFFSET_PROP, NULL) ||
+		     fdt_getprop(fdt, node, FIT_DATA_POSITION_PROP, NULL) ||
+		     fdt_getprop(fdt, node, FIT_DATA_SIZE_PROP, NULL))) {
+			fprintf(stderr,
+				"Error: image '%s': image-data must not be combined with external data properties\n",
+				fdt_get_name(fdt, node, NULL));
+			ret = -EINVAL;
+			goto err_munmap;
+		}
+
 		/*
 		 * FIT_DATA_OFFSET_PROP and FIT_DATA_POSITION_PROP are never both present,
 		 *  but if they are, prefer FIT_DATA_OFFSET_PROP as it was there first
@@ -1169,6 +1187,341 @@ err:
 	return ret;
 }
 
+/**
+ * fit_props_equal() - Check whether a property is present and equal on
+ * two nodes
+ *
+ * @fdt: FIT blob containing both nodes
+ * @node_a: offset of the first node
+ * @node_b: offset of the second node
+ * @prop: name of the property to compare
+ * Return: true if @prop is present on both nodes with identical
+ * length and value, false otherwise
+ */
+static bool fit_props_equal(const void *fdt, int node_a, int node_b,
+			    const char *prop)
+{
+	const void *a, *b;
+	int len_a, len_b;
+
+	a = fdt_getprop(fdt, node_a, prop, &len_a);
+	b = fdt_getprop(fdt, node_b, prop, &len_b);
+
+	return a && b && len_a == len_b && !memcmp(a, b, len_a);
+}
+
+/**
+ * fit_check_shared_cipher() - Check cipher settings of images sharing data
+ *
+ * Two image nodes can only share binary data if their cipher settings
+ * produce identical ciphertext: either neither is encrypted, or both
+ * use the same algorithm, key and IV. The IV must be shared explicitly,
+ * through the same iv-name-hint or, when neither node uses a hint, the
+ * same iv value; anything else, including the independent random IV
+ * generated when a node provides no IV at all, would make the
+ * ciphertexts differ. A hint drives the encryption whenever it is
+ * present, so in that case the hints themselves have to match.
+ *
+ * The check covers two situations. In a source file the nodes are not
+ * yet encrypted and their cipher settings describe how they will be;
+ * matching settings then guarantee matching ciphertext. In a
+ * re-processed FIT both nodes already carry the shared ciphertext and
+ * record the plaintext length in data-size-unciphered, which therefore
+ * has to be equal as well.
+ *
+ * @fdt: FIT blob containing both image nodes
+ * @node: offset of the image node that carries the image-data reference
+ * @target: offset of the referenced image node
+ * @name: name of the referencing image, for error messages
+ * @ref: name of the referenced image, for error messages
+ * Return: 0 if the cipher settings allow sharing, -EINVAL if they do
+ * not
+ */
+static int fit_check_shared_cipher(const void *fdt, int node, int target,
+				   const char *name, const char *ref)
+{
+	int ncipher, tcipher;
+
+	ncipher = fdt_subnode_offset(fdt, node, FIT_CIPHER_NODENAME);
+	tcipher = fdt_subnode_offset(fdt, target, FIT_CIPHER_NODENAME);
+	if (ncipher < 0 && tcipher < 0)
+		return 0;
+
+	if ((ncipher < 0) != (tcipher < 0)) {
+		fprintf(stderr,
+			"Error: image '%s' shares data with image '%s' but only one of them is encrypted\n",
+			name, ref);
+		return -EINVAL;
+	}
+	if (!fit_props_equal(fdt, ncipher, tcipher, FIT_ALGO_PROP) ||
+	    !fit_props_equal(fdt, ncipher, tcipher, FIT_KEY_HINT)) {
+		fprintf(stderr,
+			"Error: image '%s' shares data with image '%s' but their cipher settings differ\n",
+			name, ref);
+		return -EINVAL;
+	}
+	if ((fdt_getprop(fdt, node, FIT_DATA_SIZE_UNCIPHERED_PROP, NULL) ||
+	     fdt_getprop(fdt, target, FIT_DATA_SIZE_UNCIPHERED_PROP, NULL)) &&
+	    !fit_props_equal(fdt, node, target, FIT_DATA_SIZE_UNCIPHERED_PROP)) {
+		fprintf(stderr,
+			"Error: image '%s' shares data with image '%s' but data-size-unciphered differs\n",
+			name, ref);
+		return -EINVAL;
+	}
+
+	if (fdt_getprop(fdt, ncipher, FIT_IV_HINT, NULL) ||
+	    fdt_getprop(fdt, tcipher, FIT_IV_HINT, NULL)) {
+		if (!fit_props_equal(fdt, ncipher, tcipher, FIT_IV_HINT)) {
+			fprintf(stderr,
+				"Error: image '%s' shares encrypted data with image '%s'; both must use the same iv-name-hint\n",
+				name, ref);
+			return -EINVAL;
+		}
+		return 0;
+	}
+	if (!fit_props_equal(fdt, ncipher, tcipher, FIT_IV_PROP)) {
+		fprintf(stderr,
+			"Error: image '%s' shares encrypted data with image '%s'; both must use the same iv-name-hint or iv\n",
+			name, ref);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * fit_resolve_image_data() - Resolve image-data references between images
+ *
+ * An image node may carry an 'image-data' property naming another image
+ * node under /images whose binary data it shares. Copy the referenced
+ * node's data into the referencing node so that later steps (ciphering,
+ * hashing, signing and external-data extraction) see a normal image
+ * node. The property itself is retained in the FIT as a record of the
+ * sharing relationship.
+ *
+ * If the referencing node already has data (for example when mkimage
+ * re-processes a FIT it produced earlier), the data must match the
+ * target's data exactly; anything else means the FIT is malformed.
+ *
+ * This runs after fit_import_data() on purpose. A re-processed FIT
+ * with external data legitimately carries image-data next to
+ * data-offset and data-size, which is the resolved form the
+ * specification describes, so the combination cannot be rejected up
+ * front. The import turns both the plain and the shared case into
+ * inline data, and the byte comparison against the target then
+ * implements the specification's rule that a sharer whose data
+ * disagrees with its target is malformed. A source file, where the
+ * combination cannot be legitimate, is rejected by the import itself
+ * before any data is read; external data properties that the import
+ * did not consume are rejected here.
+ *
+ * @params: image tool parameters, used for the tool name in messages
+ * @fname: filename of the FIT to process
+ * Return: 0 on success, including when there is nothing to resolve,
+ * negative on error
+ */
+static int fit_resolve_image_data(struct image_tool_params *params,
+				  const char *fname)
+{
+	void *fdt = NULL, *old_fdt;
+	int new_size, size, extra;
+	int fd;
+	struct stat sbuf;
+	bool found = false;
+	int changed = 0;
+	int ret;
+	int images;
+	int node;
+
+	fd = mmap_fdt(params->cmdname, fname, 0, &old_fdt, &sbuf, false, false);
+	if (fd < 0)
+		return -EIO;
+
+	images = fdt_path_offset(old_fdt, FIT_IMAGES_PATH);
+	if (images < 0) {
+		debug("%s: Cannot find /images node: %d\n", __func__, images);
+		ret = -EINVAL;
+		goto err_munmap;
+	}
+
+	/*
+	 * Work out roughly how much larger the FIT will get, and skip the
+	 * rewrite in the common case of no references. References that do
+	 * not resolve are left for the loop below to report.
+	 */
+	extra = 0;
+	fdt_for_each_subnode(node, old_fdt, images) {
+		const char *ref;
+		int target, len;
+
+		ref = fdt_getprop(old_fdt, node, FIT_IMAGE_DATA_PROP, NULL);
+		if (!ref)
+			continue;
+		found = true;
+		target = fdt_subnode_offset(old_fdt, images, ref);
+		if (target >= 0 &&
+		    fdt_getprop(old_fdt, target, FIT_DATA_PROP, &len))
+			extra += len + 64;
+	}
+	if (!found) {
+		munmap(old_fdt, sbuf.st_size);
+		close(fd);
+		return 0;
+	}
+
+	/* Allocate space to hold the enlarged FIT */
+	size = sbuf.st_size + extra + 1024;
+	fdt = calloc(1, size);
+	if (!fdt) {
+		fprintf(stderr, "%s: Failed to allocate memory (%d bytes)\n",
+			__func__, size);
+		ret = -ENOMEM;
+		goto err_munmap;
+	}
+	ret = fdt_open_into(old_fdt, fdt, size);
+	if (ret) {
+		debug("%s: Failed to expand FIT: %s\n", __func__,
+		      fdt_strerror(ret));
+		ret = -EINVAL;
+		goto err_munmap;
+	}
+
+	images = fdt_path_offset(fdt, FIT_IMAGES_PATH);
+	fdt_for_each_subnode(node, fdt, images) {
+		const char *name = fdt_get_name(fdt, node, NULL);
+		const char *ref, *data, *tdata;
+		void *copy;
+		int target, len, tlen;
+
+		ref = fdt_getprop(fdt, node, FIT_IMAGE_DATA_PROP, NULL);
+		if (!ref)
+			continue;
+
+		target = fdt_subnode_offset(fdt, images, ref);
+		if (target < 0) {
+			fprintf(stderr,
+				"Error: image '%s': image-data references undefined image '%s'\n",
+				name, ref);
+			ret = -EINVAL;
+			goto err_munmap;
+		}
+		if (fdt_getprop(fdt, target, FIT_IMAGE_DATA_PROP, NULL)) {
+			fprintf(stderr,
+				"Error: image '%s': image-data target '%s' has an image-data property itself; chained references are not permitted\n",
+				name, ref);
+			ret = -EINVAL;
+			goto err_munmap;
+		}
+		tdata = fdt_getprop(fdt, target, FIT_DATA_PROP, &tlen);
+		if (!tdata) {
+			fprintf(stderr,
+				"Error: image '%s': image-data target '%s' has no data\n",
+				name, ref);
+			ret = -EINVAL;
+			goto err_munmap;
+		}
+
+		ret = fit_check_shared_cipher(fdt, node, target, name, ref);
+		if (ret)
+			goto err_munmap;
+
+		data = fdt_getprop(fdt, node, FIT_DATA_PROP, &len);
+		if (data) {
+			if (len != tlen || memcmp(data, tdata, len)) {
+				fprintf(stderr,
+					"Error: image '%s': data does not match image-data target '%s'\n",
+					name, ref);
+				ret = -EINVAL;
+				goto err_munmap;
+			}
+			/* Already resolved */
+			continue;
+		}
+		/*
+		 * A source file mixing image-data with a complete external
+		 * data reference was rejected before the import, and the
+		 * import consumed any complete reference of a re-processed
+		 * FIT, so what is left here is a partial form the import
+		 * refused, for example data-size without an offset.
+		 */
+		if (fdt_getprop(fdt, node, FIT_DATA_OFFSET_PROP, NULL) ||
+		    fdt_getprop(fdt, node, FIT_DATA_POSITION_PROP, NULL) ||
+		    fdt_getprop(fdt, node, FIT_DATA_SIZE_PROP, NULL)) {
+			fprintf(stderr,
+				"Error: image '%s': image-data must not be combined with external data properties\n",
+				name);
+			ret = -EINVAL;
+			goto err_munmap;
+		}
+
+		/*
+		 * Copy via a temporary buffer since fdt_setprop() moves the
+		 * tree, including the target's data, while it works
+		 */
+		copy = malloc(tlen);
+		if (!copy) {
+			fprintf(stderr,
+				"%s: Failed to allocate memory (%d bytes)\n",
+				__func__, tlen);
+			ret = -ENOMEM;
+			goto err_munmap;
+		}
+		memcpy(copy, tdata, tlen);
+		ret = fdt_setprop(fdt, node, FIT_DATA_PROP, copy, tlen);
+		free(copy);
+		if (ret) {
+			debug("%s: Failed to write property: %s\n", __func__,
+			      fdt_strerror(ret));
+			ret = -EINVAL;
+			goto err_munmap;
+		}
+		changed++;
+		debug("Resolved image-data of '%s' from '%s', size %x\n",
+		      name, ref, tlen);
+	}
+
+	munmap(old_fdt, sbuf.st_size);
+
+	/* Close the old fd so we can re-use it. */
+	close(fd);
+
+	/* All references were already resolved, leave the file as it is */
+	if (!changed) {
+		free(fdt);
+		return 0;
+	}
+
+	fdt_pack(fdt);
+
+	new_size = fdt_totalsize(fdt);
+	debug("Size expanded from %x to %x\n", (int)sbuf.st_size, new_size);
+
+	fd = open(fname, O_RDWR | O_CREAT | O_TRUNC | O_BINARY, 0666);
+	if (fd < 0) {
+		fprintf(stderr, "%s: Can't open %s: %s\n",
+			params->cmdname, fname, strerror(errno));
+		ret = -EIO;
+		goto err;
+	}
+	if (write(fd, fdt, new_size) != new_size) {
+		debug("%s: Failed to write FIT to file %s\n", __func__,
+		      strerror(errno));
+		ret = -EIO;
+		goto err;
+	}
+
+	free(fdt);
+	close(fd);
+	return 0;
+
+err_munmap:
+	munmap(old_fdt, sbuf.st_size);
+err:
+	free(fdt);
+	close(fd);
+	return ret;
+}
+
 /**
  * fit_handle_file - main FIT file processing function
  *
@@ -1234,6 +1587,11 @@ static int fit_handle_file(struct image_tool_params *params)
 	if (ret)
 		goto err_system;
 
+	/* Resolve image-data references between images, if any */
+	ret = fit_resolve_image_data(params, tmpfile);
+	if (ret)
+		goto err_system;
+
 	/*
 	 * Copy the tmpfile to bakfile, then in the following loop
 	 * we copy bakfile to tmpfile. So we always start from the
-- 
2.43.0

