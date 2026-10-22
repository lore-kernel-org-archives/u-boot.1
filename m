Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6053E606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 19:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kRtADy1+;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KbLYeGRr
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3BF2D409D1;
	Thu, 22 Oct 2026 19:41:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sO1vr9DbG-ja; Thu, 22 Oct 2026 19:41:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CEFCF409BB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792698087;
	b=EkwGuDF/7EB5Sk+LNrUzeyqYjTtB1982RTLlzIttQyATe57lvkfwlnKywGsTUWZ5FBKM
	 hyc/BJUv0A4rm/UBBGXtXuQkIHhix40DllBAX4qTlbvd7FeyMWRFyQ5N2Qopp+kVNLrnb
	 PreqzYxH/oVKREXgd1OcgEOZ4p3O5eZxRVF8oj8ks7cxfffEjSxlsMB042yWJmhlPmyGf
	 a94MDIxjvErZzK8/NTFHxvNU/OdRUmrqpMGiYDlzMEPVECCYnQA3WES6pabU+L3uAqF6L
	 gjPFxq3TbbcWALXRiX9KPQajWRSF4k+z5rFZVQ1dVOq98eNqOUJmMyE1DMZw/3MvKMQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792698087;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WcGAcfTmk66gf4V2oP2V2wQ3Ggk1TId9vWrMhlYuoP4=;
	b=F/xNnTevoVUjvVpuG2nLVkxyC/oxkfks/bD1EtkuoyNKro0Z2ACJjTp9jb4FrysLJeUl
	 cwBCW1nKRF6osyb5erM50ICzWf+e11ykOH0Iy+93IcIwdN5YBUtHlnztm8i8dme70/Ixa
	 T2iR4vKeC+MklP+8Uyue/8xNhOjyYmadIxLcX//TR0a88nD6eom/Cj93WluDBV5PVyJLh
	 VcAf9kB4Sl5mSojoyRI/mndB+CMEvgWs9VG12A0wFcNm1tEUbeunTUB0uKwfCtXix3Z+2
	 zQrnCt80C/4WbX3SV0g2fhGZrMIW+VSxA6oSrbrcsebNvFMIa6JEp5zRjIypbAmZl7A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KbLYeGRr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792698086;
	bh=WcGAcfTmk66gf4V2oP2V2wQ3Ggk1TId9vWrMhlYuoP4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kRtADy1+RO3iz1XH7aQ9mSr9Z3CKtuXsEx5dHufHdP6RnyL0XFR0p2OY0w9R99v90
	 mPM4IOM8oVqyl3KpNf3uPOUOdx5Nh5E5Wp4Tc0NvXUUhQXT7FaLcKCG/5Q2SoIJFvG
	 sXE4jeOo1j0V0NKaDNvUUg7hmeiNVS5nz9OoKaWF5ZtGjnQ4ITNc8obD3eO9x7JFgW
	 9EupNDAFzASvQUBXkoCBJYfR2WWH7cnZ1NPiaANtfJv3fEUTZDRlTNW/aK1YFu5psI
	 boOpT7dp6l4cy0fMDLAgwE1Rz/Ox93tFl+8uvvJl72NCWYNL4UJ1DDScE6PciMDetX
	 PmeqD6dXOYHZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CEFCF409BB;
	Thu, 22 Oct 2026 19:41:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BE9613C1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:41:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AF1E2409CE
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:41:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6SjaSdCmv9We for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 19:41:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 48FA3409BC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792698081;
 b=Jb929kks9u3F2ZXLyHhT2iVv4eOwVRNGpoz2HdfxK5xbsbI7GZ6LUPSAcaMBjyZCHpYm
 FSqG9h+D3l3Am9vjBXuZyHHVAlpC2wNVVJjKkgcbE20jyfgRYducjS/VIvCvwLipyZc5d
 6QgOk7P2nHyQQhdj/4p8NoKDvqGfwvRlGVOmJNo4NtLskfyZt9RRzgZ+kwh8HSorlpVtB
 enYvb6ws5Lz6HAKHF7TFwXFtDM2wYNmUfb2VJdyiXJodlO59suU8GCHPtd8a1Wtwxo7Um
 T8U5qzhejs1LSG7W+z2Y3pnWU/0Y4Xfn4cTrUPhzFs8IEYwokcXBVP1jW+fp+GZSTbg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792698081;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=WcGAcfTmk66gf4V2oP2V2wQ3Ggk1TId9vWrMhlYuoP4=;
 b=K0yWCc0WUQ0x031SwXvXRKYtsX54Evv0rELt2D4dI4GJFtfBxVLJ90Sl3PLjDUZ6UGkO
 PwOvukl8IesSdRJYiomDd3rDURDFKxgmuSJIJbkKErm6N8hg69Bvsh06gf2ePSgxN/Anm
 kVZiRYrL4TMzS3lqv7X7Uj2ysfvL3tmfk45dF4yFi90HLKGWpd8rAkltVZ4oPGQJmEfBg
 Pi5DR88srYOw/hng4f1E/N/wVH0mLmI70UJ4CpPCvKpkPdTlUvFvDTZCloP55bCideuBS
 S54IHlOUSweW6897eUEIgy9AHFaKhrKmrvl+nzb+XcZtdkB0xcG2L2tdku/GynY2UfQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=KbLYeGRr; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=KbLYeGRr
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 48FA3409BC
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:41:20 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49d0da752ffso999145e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792698079; x=1793302879;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WcGAcfTmk66gf4V2oP2V2wQ3Ggk1TId9vWrMhlYuoP4=;
 b=KbLYeGRrVhaYZJWISFXw4Ktv7XBcgvS6X6z9rLrNsvjExma4RMuHPLWHcxdIwFZI2g
 +QONXTr76cWM3wLnC7PIjPFMelwU4Lyx83zbX92JPsW3Lwo6B7tyx9dAuKppthBYn6tA
 PZ+BuaKNgJt9iZ7tXTFgEovfnbTbXi/hbMnXaTkI7RNfYNMSzvz0FoxkH4tZrek07W0C
 OtF7a3n1gCwt5ZdaPs9kbl6Ap0Qesm3xqwp+humiTtNfKIoK+RaqdrzWwqAZYNMN563b
 o+XDiCqzbf46q5ekt4ipdh+S7lhk6aIrgXBn5FyVjhmCDfPWfirfS6BjuU5xV/uXWQ8G
 59Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792698079; x=1793302879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=WcGAcfTmk66gf4V2oP2V2wQ3Ggk1TId9vWrMhlYuoP4=;
 b=eTG7zgJoI82RROvK9nNklhnld8XHQ6R/HiJojWVWzReIFCkSyKdaOPDhu0fnCl5WUh
 emO9S6DxW869thHDGWNIyxsdBMlIgcy6Qy4atb6ca2bH+z019vlVkKQvFFA3VL/dqaIL
 cb/56Tv/D5n6r1SmETMDoISWf5wuuLJFASdxBuJyfrx/TDlvXxo7dp3vh5Rw3A3Hfgyp
 zkuwy9TmfsjDsyTwvwODBWe4VVgbfyTkmhprBxi94MoCu7xHyvnn8swz2b46R0IlAdqI
 N8mvBN7+iEHbDkJCl/JdlpH5PZmzs7ezPFO/pD/k4+MEMPJYdXJlRcF2X0vcqV5vm06r
 qZjg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzHIfmgErAe7U9YxetQNLFdE185CdUsqJsfzmOnHXtgR0fz8WplO95flymMrN8pPju6YdrBvY4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK76hYCI87vaZdPABFZqn/H9qdjX+P4ZU0txPgLhTYsjOKJlDl8
 bttXokPhu4aYuc/l7rRITIU7NrwwBa74xZgtdUhJ3NXsBVyrpEulaVtX
X-Gm-Gg: AYBFou1MdiV3FM+gvhJLauzx+E5Vm1/yxMaTKLUYjpYJvbV6YSwkjbpMhhR8x80yCf1
 kKJthtsWiu6RzC9QpHb4xI20KWx55Rm0er/NWZAgY2mEUGJevZsvJ6kGORi0Ps+sU1JyMVVJ9EX
 xlTBjaBZ9MnSG9KOMTtZPOwj9+gPhZZV6Bm/E7/a+bqvKyTzXdJ9rDDT7BDtssMJ1g576dg9kTE
 I18xSnnWRHQMMRmSop+C9pwZ2WgJkc50LPjld1hlp+6mXeWbNMnBGAGi7iVmrrah7zMtTzgsTir
 kTQ0NF/ohi42hZEsFElLFw1395FVkrAsKbIxZswW7u1uf6oAEv+EB1CXdFZrzOWmRx0vnMCmJgl
 gkttJus+iD3yYwsCcqylVxtg3hUMLs57q8zzW7uPc+UcOFH8pSogwGacsXrfA0OMA1pAZYiecEO
 u9M7rl7ATZ9Hy/zGJ307EdRPZlssrfOWb0QsDolm5QKKdMAjt2u53lUGa5qxNGD5jdDAmqTfdD9
 yqbl0GOIijzbI57tZqyh8P44iSHu1TIBud/Ab+jLk2UuuPIgzpgGN4mDm5SU2VDGOU1qXLUG9Bn
 CN1Si/MvqVz7Pz9fHNk6IOcDKwEVEUbhXf9Jka1Fw/rfJODaBBh7CLf0K/Oq2jNV1dKp3+NaO8c
 22DmVXA==
X-Received: by 2002:a05:600c:3b0c:b0:4a1:a6e0:4ce4 with SMTP id
 5b1f17b1804b1-4a211efe5c5mr1180585e9.33.1792698078719; 
 Thu, 22 Oct 2026 12:41:18 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4a211be8f79sm3185715e9.14.2026.10.22.12.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 12:41:16 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>,
 Aristo Chen <aristo.chen@canonical.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Tan Siewert <tan.siewert@9elements.com>, Peng Fan <peng.fan@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Subject: [PATCH v8 7/7] test: dm: Add test for FW Loader feature
Date: Thu, 22 Oct 2026 21:40:42 +0200
Message-ID: <20261022194049.670889-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022194049.670889-1-ansuelsmth@gmail.com>
References: <20261022194049.670889-1-ansuelsmth@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add basic test for FW Loader feature for the Filesystem way and FIP.

Additional MMC testing image are added that loads a dummy firmware.bin in
a fat partition or a simple FIP blob.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/sandbox/dts/test.dts          |  38 +++++
 configs/sandbox64_defconfig        |   2 +
 configs/sandbox_defconfig          |   2 +
 configs/sandbox_flattree_defconfig |   2 +
 configs/sandbox_noinst_defconfig   |   1 +
 configs/sandbox_spl_defconfig      |   2 +
 configs/sandbox_vpl_defconfig      |   2 +
 test/dm/Makefile                   |   1 +
 test/dm/fw_loader.c                | 218 +++++++++++++++++++++++++++++
 test/py/tests/fip/test.fip         | Bin 0 -> 101 bytes
 test/py/tests/test_ut.py           |  26 ++++
 11 files changed, 294 insertions(+)
 create mode 100644 test/dm/fw_loader.c
 create mode 100644 test/py/tests/fip/test.fip

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 25c99ef81472..772d8dd548bc 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -189,6 +189,18 @@
 		};
 	};
 
+	fs_loader: fs-loader {
+		bootph-all;
+		compatible = "u-boot,fs-loader";
+		phandlepart = <&mmc12 1>;
+	};
+
+	fip_loader: fip-loader {
+		bootph-all;
+		compatible = "u-boot,fip-loader";
+		phandlepart = <&mmc13 1>;
+	};
+
 	cedit: cedit {
 	};
 
@@ -1398,6 +1410,20 @@
 		filename = "mmc11.img";
 	};
 
+	/* This is used for FS Loader tests */
+	mmc12: mmc12 {
+		status = "disabled";
+		compatible = "sandbox,mmc";
+		filename = "mmc12.img";
+	};
+
+	/* This is used for FIP Loader tests */
+	mmc13: mmc13 {
+		status = "disabled";
+		compatible = "sandbox,mmc";
+		filename = "mmc13.img";
+	};
+
 	pch {
 		compatible = "sandbox,pch";
 	};
@@ -2143,6 +2169,18 @@
 		ethphy1: ethernet-phy@1 {
 			reg = <1>;
 		};
+
+		ethernet-phy@2 {
+			reg = <2>;
+
+			firmware-loader = <&fs_loader>;
+		};
+
+		ethernet-phy@3 {
+			reg = <3>;
+
+			firmware-loader = <&fip_loader>;
+		};
 	};
 
 	pm-bus-test {
diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index 59e08d03f776..7d56ab984c1d 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -266,9 +266,11 @@ CONFIG_WDT=y
 CONFIG_WDT_GPIO=y
 CONFIG_WDT_SANDBOX=y
 CONFIG_WDT_ALARM_SANDBOX=y
+CONFIG_FIP_LOADER=y
 CONFIG_FS_CBFS=y
 CONFIG_FS_EXFAT=y
 CONFIG_FS_CRAMFS=y
+CONFIG_FS_LOADER=y
 CONFIG_CMD_DHRYSTONE=y
 CONFIG_TPM=y
 CONFIG_ERRNO_STR=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index f307972a762d..cf3c858b4b72 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -383,9 +383,11 @@ CONFIG_WDT_GPIO=y
 CONFIG_WDT_SANDBOX=y
 CONFIG_WDT_ALARM_SANDBOX=y
 CONFIG_WDT_FTWDT010=y
+CONFIG_FIP_LOADER=y
 CONFIG_FS_CBFS=y
 CONFIG_FS_EXFAT=y
 CONFIG_FS_CRAMFS=y
+CONFIG_FS_LOADER=y
 CONFIG_ADDR_MAP=y
 CONFIG_PANIC_HANG=y
 CONFIG_PMBUS=y
diff --git a/configs/sandbox_flattree_defconfig b/configs/sandbox_flattree_defconfig
index 57f915d4ba9a..3488036ddf8f 100644
--- a/configs/sandbox_flattree_defconfig
+++ b/configs/sandbox_flattree_defconfig
@@ -12,10 +12,12 @@ CONFIG_EFI_CAPSULE_FIRMWARE_FIT=y
 CONFIG_EFI_CAPSULE_AUTHENTICATE=y
 CONFIG_EFI_CAPSULE_CRT_FILE="board/sandbox/capsule_pub_key_good.crt"
 CONFIG_BUTTON_CMD=y
+CONFIG_FIP_LOADER=y
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERITY=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_FS_LOADER=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_BOOTSTAGE=y
 CONFIG_BOOTSTAGE_REPORT=y
diff --git a/configs/sandbox_noinst_defconfig b/configs/sandbox_noinst_defconfig
index 7a7550127956..941bf2d69431 100644
--- a/configs/sandbox_noinst_defconfig
+++ b/configs/sandbox_noinst_defconfig
@@ -21,6 +21,7 @@ CONFIG_SYS_MEMTEST_END=0x00101000
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_FS_LOADER=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_HAS_LOAD_FIT_ADDRESS=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x0
diff --git a/configs/sandbox_spl_defconfig b/configs/sandbox_spl_defconfig
index 60b497f48886..183611632ef8 100644
--- a/configs/sandbox_spl_defconfig
+++ b/configs/sandbox_spl_defconfig
@@ -223,8 +223,10 @@ CONFIG_I2C_EDID=y
 CONFIG_VIDEO_SANDBOX_SDL=y
 CONFIG_OSD=y
 CONFIG_SANDBOX_OSD=y
+CONFIG_FIP_LOADER=y
 CONFIG_FS_CBFS=y
 CONFIG_FS_CRAMFS=y
+CONFIG_FS_LOADER=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_CMD_DHRYSTONE=y
 CONFIG_RSA_VERIFY_WITH_PKEY=y
diff --git a/configs/sandbox_vpl_defconfig b/configs/sandbox_vpl_defconfig
index c85bfbfb3b15..445e979915e8 100644
--- a/configs/sandbox_vpl_defconfig
+++ b/configs/sandbox_vpl_defconfig
@@ -231,8 +231,10 @@ CONFIG_CONSOLE_TRUETYPE_CANTORAONE=y
 CONFIG_VIDEO_SANDBOX_SDL=y
 CONFIG_OSD=y
 CONFIG_SANDBOX_OSD=y
+CONFIG_FIP_LOADER=y
 CONFIG_FS_CBFS=y
 CONFIG_FS_CRAMFS=y
+CONFIG_FS_LOADER=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_CMD_DHRYSTONE=y
 CONFIG_RSA_VERIFY_WITH_PKEY=y
diff --git a/test/dm/Makefile b/test/dm/Makefile
index 5dd6b57bbe84..2f095ceedd8c 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_EXTCON) += extcon.o
 ifneq ($(CONFIG_EFI_PARTITION),)
 obj-$(CONFIG_FASTBOOT_FLASH_MMC) += fastboot.o
 endif
+obj-$(CONFIG_FW_LOADER_UCLASS) += fw_loader.o
 obj-$(CONFIG_FIRMWARE) += firmware.o
 obj-$(CONFIG_DM_FPGA) += fpga.o
 obj-$(CONFIG_FWU_MDATA_GPT_BLK) += fwu_mdata.o
diff --git a/test/dm/fw_loader.c b/test/dm/fw_loader.c
new file mode 100644
index 000000000000..71065602cb58
--- /dev/null
+++ b/test/dm/fw_loader.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <dm.h>
+#include <dm/device.h>
+#include <dm/lists.h>
+#include <dm/test.h>
+#include <fw_loader.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+static int bind_mmc(struct unit_test_state *uts, const char *mmc)
+{
+	struct udevice *dev;
+	ofnode root, node;
+
+	/* Enable the mmc12 node for this test */
+	root = oftree_root(oftree_default());
+	node = ofnode_find_subnode(root, mmc);
+	ut_assert(ofnode_valid(node));
+	ut_assertok(lists_bind_fdt(gd->dm_root, node, &dev, NULL, false));
+
+	return 0;
+}
+
+static int dm_test_fw_loader_get_dev(struct unit_test_state *uts,
+				     const char *name, struct udevice **dev)
+{
+	struct udevice *mdio_dev;
+	ofnode mdio_node, phy_node;
+
+	ut_assertok(uclass_get_device_by_name(UCLASS_MDIO, "mdio-test",
+					      &mdio_dev));
+
+	mdio_node = dev_ofnode(mdio_dev);
+	ut_assert(ofnode_valid(mdio_node));
+
+	phy_node = ofnode_find_subnode(mdio_node, name);
+	ut_assert(ofnode_valid(phy_node));
+
+	return get_fw_loader_from_node(phy_node, dev);
+}
+
+static int dm_test_fs_loader_get(struct unit_test_state *uts)
+{
+	struct udevice *fw_loader_dev = NULL;
+	int ret;
+
+	ut_assertok(bind_mmc(uts, "mmc12"));
+
+	ret = dm_test_fw_loader_get_dev(uts, "ethernet-phy@1", &fw_loader_dev);
+	ut_asserteq(-ENODEV, ret);
+	ut_assertnull(fw_loader_dev);
+
+	fw_loader_dev = NULL;
+	ret = dm_test_fw_loader_get_dev(uts, "ethernet-phy@2", &fw_loader_dev);
+	ut_assertok(ret);
+	ut_assertnonnull(fw_loader_dev);
+
+	return 0;
+}
+DM_TEST(dm_test_fs_loader_get, UTF_SCAN_FDT);
+
+static int dm_test_fip_loader_get(struct unit_test_state *uts)
+{
+	struct udevice *fw_loader_dev = NULL;
+	int ret;
+
+	ut_assertok(bind_mmc(uts, "mmc13"));
+
+	ret = dm_test_fw_loader_get_dev(uts, "ethernet-phy@3", &fw_loader_dev);
+	ut_assertok(ret);
+	ut_assertnonnull(fw_loader_dev);
+
+	return 0;
+}
+DM_TEST(dm_test_fip_loader_get, UTF_SCAN_FDT);
+
+static int dm_test_fs_loader_get_fw_size(struct unit_test_state *uts)
+{
+	struct udevice *fw_loader_dev = NULL;
+	int ret;
+
+	ut_assertok(bind_mmc(uts, "mmc12"));
+
+	ret = dm_test_fw_loader_get_dev(uts, "ethernet-phy@2", &fw_loader_dev);
+	ut_assertok(ret);
+	ut_assertnonnull(fw_loader_dev);
+
+	ret = request_firmware_size(fw_loader_dev, "firmware.bin");
+	ut_asserteq(256, ret);
+
+	return 0;
+}
+DM_TEST(dm_test_fs_loader_get_fw_size, UTF_SCAN_FDT);
+
+static int dm_test_fip_loader_get_fw_size(struct unit_test_state *uts)
+{
+	struct udevice *fw_loader_dev = NULL;
+	int ret;
+
+	ut_assertok(bind_mmc(uts, "mmc13"));
+
+	ret = dm_test_fw_loader_get_dev(uts, "ethernet-phy@3", &fw_loader_dev);
+	ut_assertok(ret);
+	ut_assertnonnull(fw_loader_dev);
+
+	ret = request_firmware_size(fw_loader_dev,
+				    "45a113ac-c7f2-30b0-90a5-a399ab912716");
+	ut_asserteq(5, ret);
+
+	return 0;
+}
+DM_TEST(dm_test_fip_loader_get_fw_size, UTF_SCAN_FDT);
+
+static int dm_test_fs_loader_get_fw_in_buf(struct unit_test_state *uts)
+{
+	struct udevice *fw_loader_dev = NULL;
+	int firmware_size = 256;
+	char *buf;
+	int ret;
+
+	ut_assertok(bind_mmc(uts, "mmc12"));
+
+	ret = dm_test_fw_loader_get_dev(uts, "ethernet-phy@2", &fw_loader_dev);
+	ut_assertok(ret);
+	ut_assertnonnull(fw_loader_dev);
+
+	ret = request_firmware_size(fw_loader_dev, "firmware.bin");
+	ut_asserteq(firmware_size, ret);
+
+	buf = calloc(firmware_size, sizeof(*buf));
+	ut_assertnonnull(buf);
+
+	ret = request_firmware_into_buf(fw_loader_dev, "firmware.bin",
+					buf, firmware_size, 0);
+	ut_asserteq(firmware_size, ret);
+
+	ret = request_firmware_into_buf(fw_loader_dev, "firmware.bin",
+					buf, firmware_size - 10, 10);
+	ut_asserteq(firmware_size - 10, ret);
+
+	ret = request_firmware_into_buf(fw_loader_dev, "firmware.bin",
+					buf, firmware_size, firmware_size);
+	ut_asserteq(0, ret);
+
+	ret = request_firmware_into_buf(fw_loader_dev, "firmware.bin",
+					buf, firmware_size, firmware_size + 1);
+	ut_asserteq(0, ret);
+
+	ret = request_firmware_into_buf(fw_loader_dev, "firmware2.bin",
+					buf, firmware_size, 0);
+	ut_asserteq(-ENOENT, ret);
+
+	free(buf);
+	return 0;
+}
+DM_TEST(dm_test_fs_loader_get_fw_in_buf, UTF_SCAN_FDT);
+
+static int dm_test_fip_loader_get_fw_in_buf(struct unit_test_state *uts)
+{
+	struct udevice *fw_loader_dev = NULL;
+	int firmware_size = 5;
+	char *buf;
+	int ret;
+
+	ut_assertok(bind_mmc(uts, "mmc13"));
+
+	ret = dm_test_fw_loader_get_dev(uts, "ethernet-phy@3", &fw_loader_dev);
+	ut_assertok(ret);
+	ut_assertnonnull(fw_loader_dev);
+
+	/* uuidgen -n @dns --md5 --name test = 45a113ac-c7f2-30b0-90a5-a399ab912716*/
+	ret = request_firmware_size(fw_loader_dev,
+				    "45a113ac-c7f2-30b0-90a5-a399ab912716");
+	ut_asserteq(firmware_size, ret);
+
+	buf = calloc(firmware_size, sizeof(*buf));
+	ut_assertnonnull(buf);
+
+	ret = request_firmware_into_buf(fw_loader_dev,
+					"45a113ac-c7f2-30b0-90a5-a399ab912716",
+					buf, firmware_size, 0);
+	ut_asserteq(firmware_size, ret);
+	ut_asserteq_mem("test\n", buf, firmware_size);
+
+	memset(buf, 0, firmware_size);
+	ret = request_firmware_into_buf(fw_loader_dev,
+					"45a113ac-c7f2-30b0-90a5-a399ab912716",
+					buf, firmware_size - 1, 0);
+	ut_asserteq(firmware_size - 1, ret);
+	ut_asserteq_mem("test", buf, firmware_size - 1);
+
+	memset(buf, 0, firmware_size);
+	ret = request_firmware_into_buf(fw_loader_dev,
+					"45a113ac-c7f2-30b0-90a5-a399ab912716",
+					buf, firmware_size - 2, 2);
+	ut_asserteq(firmware_size - 2, ret);
+	ut_asserteq_mem("st\n", buf, firmware_size - 2);
+
+	ret = request_firmware_into_buf(fw_loader_dev,
+					"45a113ac-c7f2-30b0-90a5-a399ab912716",
+					buf, firmware_size, firmware_size);
+	ut_asserteq(0, ret);
+
+	ret = request_firmware_into_buf(fw_loader_dev,
+					"45a113ac-c7f2-30b0-90a5-a399ab912716",
+					buf, firmware_size, firmware_size + 1);
+	ut_asserteq(-EINVAL, ret);
+
+	ret = request_firmware_into_buf(fw_loader_dev,
+					"300b74d6-cc34-4e68-ba5d-733157f633f7",
+					buf, firmware_size, 0);
+	ut_asserteq(-ENOENT, ret);
+
+	free(buf);
+	return 0;
+}
+DM_TEST(dm_test_fip_loader_get_fw_in_buf, UTF_SCAN_FDT);
diff --git a/test/py/tests/fip/test.fip b/test/py/tests/fip/test.fip
new file mode 100644
index 0000000000000000000000000000000000000000..a793dfd05c016b2bfe693a0b908877689abe8e5b
GIT binary patch
literal 101
zcmZQ%NLf`8W+KD@1+EK)*Bt+3uwlZ|#WPn=R2NHtinGEL;Gk1+h?k@mmv8|9cc={D

literal 0
HcmV?d00001

diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 2a5acc18c612..f3da9f3ef005 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -685,6 +685,31 @@ def test_ut_dm_init(ubman):
     with open(fn, 'wb') as fh:
         fh.write(data)
 
+def setup_fw_loader_image(ubman):
+    """Create a 2MB disk image with a dummy firmware on it"""
+    mmc_dev = 12
+    fname, mnt = fs_helper.setup_image(ubman, mmc_dev, 0xc, img_size=2)
+
+    fw = os.path.join(mnt, 'firmware.bin')
+    data = b'\xaa' * 256
+    with open(fw, 'wb') as fh:
+        fh.write(data)
+
+    fsfile = 'vfat1M.img'
+    utils.run_and_log(ubman, f'fallocate -l 1M {fsfile}')
+    utils.run_and_log(ubman, f'mkfs.vfat {fsfile}')
+    utils.run_and_log(ubman, ['sh', '-c', f'mcopy -i {fsfile} {mnt}/* ::/'])
+    copy_partition(ubman, fsfile, fname)
+    utils.run_and_log(ubman, f'rm -rf {mnt}')
+    utils.run_and_log(ubman, f'rm -f {fsfile}')
+
+    mmc_dev = 13
+    fname, mnt = fs_helper.setup_image(ubman, mmc_dev, 0x83, img_size=2)
+
+    fipfile = os.path.join(ubman.config.source_dir,
+                            'test/py/tests/fip/test.fip')
+    copy_partition(ubman, fipfile, fname)
+    utils.run_and_log(ubman, f'rm -rf {mnt}')
 
 def setup_efi_image(ubman):
     """Create a 20MB disk image with an EFI app on it"""
@@ -752,6 +777,7 @@ def test_ut_dm_init_bootstd(ubman):
     setup_cedit_file(ubman)
     setup_cros_image(ubman)
     setup_android_image(ubman)
+    setup_fw_loader_image(ubman)
     setup_efi_image(ubman)
     setup_rauc_image(ubman)
     setup_bls_prefix_image(ubman)
-- 
2.55.0

