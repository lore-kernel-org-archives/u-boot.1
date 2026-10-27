Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11EC60A3821
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dxC54lIJ;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dDRfl1m7
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 74A6760708;
	Tue, 27 Oct 2026 12:39:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4lUGRE3TfseD; Tue, 27 Oct 2026 12:39:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5036F60725
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793104760;
	b=cuoJL4+dj/olQz98n3UpDX6JpMwahHQauPP6yALv4bYu092jVoInYYeGZhedrlhegrc1
	 +yd1gPDC3/+9HgCA5nxIlp8r4k5K63AUr14vDA3fl6HOB9EPQyABb85RwErUPqAb6LL7/
	 Zk/sHtgHFtOH20PMyD5zr6uiLPlFWiNUCBolMcsZUK6oEKBH/BJC/UnTRS2sfe7huth+r
	 xgtHarCFho/ltAssouqPg7fKCPgykd/9H/XcZ2mPpXi/KIYSWGvF5ifSajxreGHUls+zI
	 Je/ivsYos0TM0LCXeagqmyQBv56teuIK8m6jbb27d05JyvWxA5fxwdZnCVcT2s6eZ9Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793104760;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NkkElDU2d2MtNod03hxgJX5bRBp6qy+/+0cHxWHHe/8=;
	b=VfFF9tEDPRGCl9wMOhEcPVSn4HtKRfjXGPj0DP4rs58lqGK+BIg0kopws+jAPqZgBJpc
	 +6ggWcNMNIrrybDHlta2IT9QmSdTf8svgtC99SdQcRiuP354CNsZ9OZkNqe0Rs8ME5oNC
	 HMUMS/dtDhP5jVjnbDFmnu4vLFhXlZ+5iGP0lfwYsx6B2W6Pf974hqRUUE3rd25v5LbXv
	 hm/phAdf+deAQwwHD1n3o9NjR12/myDM89bvvEqKwP4BkqDA0HRlmBbRMyrpGvUSxsWfF
	 xKIGlYe1whPLS/a+hh7Fvk+92EoiHMn1WVTMsaBkX79FAmjgz90ZzzJQwPCm6LG6zEA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793104760;
	bh=NkkElDU2d2MtNod03hxgJX5bRBp6qy+/+0cHxWHHe/8=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dxC54lIJRsnBVVBoHUFiwTTREl5Vz7i2F8iVGG1KqedjSBa0NtHnvSSCwDqPg5Go+
	 MNk7tpZjYl44RUXp71KqvZEQWoR/C30cmr3AWfHS+i/UsaHe5K49rAxvAYwnWFdAE0
	 JGHaU/ZhlVCqOZVAG16aLwUb6GJYPfA2cFLFv4kBgZuWAltlDSGdGwZ4MqU13rgU3Z
	 7EN+It2wphmThSRqZbDLsoFvSxMvD8o6ArPYPFiDqNshZeAXA2vSfmctkiQ1hOWtaR
	 FYdMqemA/fReig6r4W0/Ymcp1Ahl8UOZ1ET1cwcHUCSZmmHuNsGGLQxDmSk2uKAmbp
	 GpqDE/w9QEgyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5036F60725;
	Tue, 27 Oct 2026 12:39:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D2C7279
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:39:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5330B4060C
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:39:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HLjeWO5d50Wd for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 12:39:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 02B034059B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793104757;
 b=VPmmfmTuOadjS1aarcGjIPnEWHHqlUsbaYbztoHvdg1OLJ/Yn8NIrNR/FO5171djTLwR
 FkyxI3AeepKueySI5nnxV6Z4GLW8C5QxAdPgIdhQqmtrdydmh+aoj7FdW4scOE45cjUPl
 Etol1G8R02LdD8eXR/eNKakxuTeWyeb7rsSDP1LsY+z3OjIqXEdAALeD8247gE/kRpmjj
 W2jG2kuL7RjSSxc1BYJkZgZzua2rhXtVmxbX60dylbDzZ0adxZEDeb7qJWkLpCs+f3hTJ
 4mTW8sEONMA5LXX9km4OYcxX6ohMMVeFSvLfwi8vPYbqgbI4tEw12FO7WKuvEpBRhIA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793104757;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=NkkElDU2d2MtNod03hxgJX5bRBp6qy+/+0cHxWHHe/8=;
 b=q+mnj/jKEE7XYdoHwWrCBuo1PfqDOVbZcQbfUUwrr9NRPXA+j5jd5LyQF1QHRqg614fH
 IyumIgA/JgvJRAcyOBLbFj4dzQQOb3es+0f2ufhUSMu2HabJjKY6V7iHqf3G6RsK2b1Jk
 JnJ0BGnRoTCt0jFKJDidBi88NHEtlTVDPbRAiJKw1UEtBAwxwfDQyc9RL4Dnv0PZ0Bsa0
 PFjQBuZSoaUDBLEcurUqMIw0KeaVb+3VtF646vK6pivNwZlfQs59aFppKemLb2azNSv6m
 a1Ztp9J10LhJUn9JjwdyN6RzT8fu9RqvgFNk8+JpeFPBe2mGEiXagExRFPXPqVOmDzQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=dDRfl1m7; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=dDRfl1m7
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 02B034059B
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:39:16 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48df54150dfso2187729f8f.0
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 05:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793104755; x=1793709555;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NkkElDU2d2MtNod03hxgJX5bRBp6qy+/+0cHxWHHe/8=;
 b=dDRfl1m7rtb4IN1Lx6E2Xal2YRXHcfCACU1kPR37Kl/euQ1ZKtgk9Eh8VA/dib8GlR
 nMTa0JnlrSVU/15CPscFunuwLin2z17Lod5KYYCS4cvXfNrlDAIrlAlVpj3W8T39WBHy
 2/dVr9EmJf+DnhVCe5R7iEWYGmvUOssWt70SE1HO8BW3SoHm8YZholF9gd+fIexgrozc
 6Q/cJxm1C3KhN4qIyB9CKYRD0fWhpKEOvtRXHb2Yb7qsjLACTz+XLqXEc7vHBv8wOliX
 34gD573xuqBSvROJBzKXWtlmaD0/idjY4nxg6wkFuraeCV+S9quAd5VTpITVePOUEfM5
 Wb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793104755; x=1793709555;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NkkElDU2d2MtNod03hxgJX5bRBp6qy+/+0cHxWHHe/8=;
 b=T2h5qmPgwnN4XvAp9TJr2LVyGli0EtqdYp6OdLmBWhpSidoA2JgcqesVjoYxyVzzUg
 kCSB7SBqVlbakDJdjGZk8jjYPCh8ysAByfaAAVcrdhc9QEs38Yr6D1XNPK/FFAzif55u
 gst38usJeSCGfoQsH7p+r1T+r46WTegjzhRZZ/eqa+rQRDvsv8vliyGE8QV21R9CGpEC
 eL5pWfI5YHM8dyfW8oRvhnWwJ9fEXLlzm6IOHkj+fGWE0nujqFi47U935+rx/Kr7uqMF
 fFnF0sJybSMsFpGD0mpCPHMPKdiHbsJv2gSL9k86/HXupgZB1KH2dppkazkthlkVGb93
 hocg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwEjIwW4ap5M3eCkhwd6KK3pSO2FRPBsuMytqUCGU3iOu6E/OT3cZLL46F/C+i4qc2O87urcXE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIm6BeRZDqG0Otedw7YSUAgPHpLF3YVFW8XkLV++xa2Af/dR95P
 P7drrtxJK1P6AhSix7kGI+jKYdYxCW1ymbFeDZLFtPcKxf0tm5dTVxXI
X-Gm-Gg: AYBFou0NG+kozXwnrqd8OzJSo2Es43W25+m37cCj+I2OTdxgrngBiNbX4jnsDPfn7Vc
 T1zgPwUMgt+mycXFGdM1/7I0SclWMdeLqH2+TlVti/QjxaZMv1wy4shE2RY216t+Yp7ondz6e4s
 8VX7co0XmFSASXttIeJ/3OGiy34+3hTpTD32C6R09Me3+yd4Y/7StA6AQDpaISx8kRSy5gUqZ56
 I2f8HbgWIoXQWV1aAKQAYEaxuljH66k91Yb7Qj6+prdVghD0Nq+2d+S/VH5LkuCBFjE4a3A9vZR
 rbzvhxqAVdV7+wGq4r04E0EuL2M5FdObjgHfTHCBVdcHkYdGG9CJS83dEkG+jLMPzmCdVb1PMnG
 ondw3ioiPKM5iZI2Sd+v3KrnF+h/A798czm++PAVX8Q+zQFMccdV2mYcEWGr16mT9jRfjUaMRwP
 ORotTpNN3qHjMRZxG8wVhdAKykoaOviEI3q/pcLqzAUXAmoI7+lN4F7/TQkIqZji4kgSja7Yeyw
 V1H+rAW1IO2vLALl6oumpMDamcQibulxx0xZ/zQy2M9e5aPmHt+hVK7KnxbS9qDEw6K2vFR12L6
 76paxGGY69/9kN3KPnF5pNjs1PZwFnvw2E4GmCmSKVYQlopS3fsOcOJRrCDW
X-Received: by 2002:a05:6000:41c3:b0:48e:f07:160e with SMTP id
 ffacd0b85a97d-48e3eb98eeemr17498220f8f.38.1793104754556; 
 Tue, 27 Oct 2026 05:39:14 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd8c05sm29142078f8f.49.2026.10.27.05.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 05:39:14 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Alexey Charkov <alchark@flipper.net>,
 Rasmus Villemoes <ravi@prevas.dk>, "Lucien.Jheng" <lucienzx159@gmail.com>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Neha Malcom Francis <n-francis@ti.com>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@nxp.com>, Martin Schwan <m.schwan@phytec.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
Subject: [PATCH v11 0/8] misc: fs_loader: reorg and split to FS and FW loader
 + FIP loader
Date: Tue, 27 Oct 2026 13:38:55 +0100
Message-ID: <20261027123905.839-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
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
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series mainly rework the FS loader to permit reading firmware from
container that are not exactly a readable filesystem.

Also splitting out the generic firmware loader infra from the
filesystem-specific code will make adding new loader types easier.

One scenario is when a firmware is shipped in a FIP container as
a generic blob with an UUID.

FIP are mostly used on ARM in the context of ATF.
In such context U-Boot is loaded as BL31 and the PHY firmware
can't be stored in the FIT image for the kernel as U-Boot should
not depend on the presence of the kernel to correctly enable PHY
for Ethernet port.

To handle such case the PHY firmware is stored in FIP with a
predictable UUID.

One example is with Airoha 8811H firmware where the FIP can
have a blob with UUID "d39d2cf2-9bd0-3ca7-93e9-e71b4f9250b2".
(generated from command "uuidgen -n @dns --md5 --name en8811h.bin")

With these example DTS entry:

fw_loader0: fip-loader {
	bootph-all;
	compatible = "u-boot,fip-loader";
	phandlepart = <&mmc0 0>;
	partoffset = <0x100>;
};

mdio {
  en8811: ethernet-phy@f {
    reg = <0xf>;
    firmware-name = "d39d2cf2-9bd0-3ca7-93e9-e71b4f9250b2";
    firmware-loader = <&fw_loader0>;
  };
};

And PHY driver using the get_fw_loader_from_node() and the
common request_firmware_into_buf() it's possible to
load the PHY firmware transparently by just declaring
the required entry in the DTS.

get_fw_loader_from_node() is implemented to actual get the
loader from DT. This was something that was already in mind
from when the FS loader was implemented but then it was
never implemented in favor of a single loader per device.

The first patch is a minor fixup for something that probably
won't ever happen.

The second one is a good reworking of the FS and FW loader
moving the internal struct to a dedicated header. (this is
really to enforce what drivers should use and what
driver should not mess with)

Then there is the request_firmware_size() new OP to get only
the size of the firmware. Useful for case where the firmware
size is not always the same and change across different version.
(the patter might be get size -> alloc buffer -> get firmware).

Then the FIP loader as a basic parser of FIP. This only
read the FIP header, loop all the entry and search for a
matching UUID. If nothing is found then no firmware blob.
Very simple implementation.

This is being CI tested on [0]

[0] https://github.com/u-boot/u-boot/pull/884

Changes v11:
- Address request for test patch from v9
- Add additional test and comments
- Validate memory for FS test
- Fix defconfig order
Changes v10:
- Add review tag by Simon
- Use min_t for FIP driver
- Prevent double mount of ubi
Changes v9:
- Drop FIP blob in favor of dynamic generation
- Rename fs_loader to fw_loader
- Add additional patch for offset validation
- More use of lbaint_t
- Handle reading 0 for UBI
- Update MTD/UBI documentation and YAML conditions
- Make generic_fw_loader_get_phandle_desc handling explicit
Changes v8:
- Address all the comments from Simon
- Massively improve test coverage for both FS and FIP
- Enable mmc node when needed for the tests
- Change FIP implementation to follow FS one
  (read up to buf size or end of entry size)
  (complain when offset is bigger than size of entry)
- Update related documentation for fw loader
- Rebase on top of next
Changes v7:
- Add tests
- Rebase on top of next
- Fix compilation for vpl
Changes v6:
- Rework to generic FW loader UCLASS
- Account for firmware offset in FIP loader
- Add UBI example in documentation
- Improve variables order
Changes v5:
- Fix unment dependency for config flag
- Move request_firmware_size before FIP loader
- Add documentation patch
- Improve get_fw_loader_from_node() implementation
- use min() instead of custom MIN()
- Fix handling of some return value
Changes v4:
- Rebase on top of next
Changes v3:
- Add review tag where possible
- Check blk_dread ret
- Generalize mount_ubifs with generic_fw_loader_ubi_select
- Fix some typo
- Drop useless ubifs umount (nothing is mounted in FIP)
Changes v2:
- Better handle header include to fix compilation error
  on some devices
- Fix typo for ubifs fix commit

Christian Marangi (8):
  misc: fs_loader: fix ubifs not unmounted on dev_get_priv error
  misc: fs_loader: reorganize and split to FS loader and FW UCLASS
  misc: fw_loader: implement generic get_fw_loader_from_node()
  misc: fs_loader: validate requested offset on reading file
  misc: fw_loader: implement request_firmware_size() OP
  doc: dtbinding: Update documentation for Generic Firmware loader
  misc: fw_loader: introduce FIP loader driver
  test: dm: Add test for FW Loader feature

 arch/sandbox/dts/test.dts                     |  38 ++
 configs/sandbox64_defconfig                   |   2 +
 configs/sandbox_defconfig                     |   2 +
 configs/sandbox_flattree_defconfig            |   2 +
 configs/sandbox_noinst_defconfig              |   2 +
 configs/sandbox_spl_defconfig                 |   4 +
 configs/sandbox_vpl_defconfig                 |   4 +
 ...irmware_loader.rst => firmware_loader.rst} |   6 +-
 doc/develop/driver-model/index.rst            |   2 +-
 doc/device-tree-bindings/misc/fs_loader.txt   |  48 --
 doc/device-tree-bindings/misc/fw_loader.yaml  | 112 ++++
 drivers/misc/Kconfig                          |  31 +
 drivers/misc/Makefile                         |   2 +-
 drivers/misc/fs_loader.c                      | 326 ----------
 drivers/misc/fw_loader/Makefile               |   5 +
 drivers/misc/fw_loader/fip_loader.c           | 558 ++++++++++++++++++
 drivers/misc/fw_loader/fs_loader.c            | 260 ++++++++
 drivers/misc/fw_loader/fw_loader-uclass.c     | 231 ++++++++
 drivers/misc/fw_loader/internal.h             | 100 ++++
 include/dm/uclass-id.h                        |   2 +-
 include/fs_loader.h                           |  47 +-
 include/fw_loader.h                           |  42 ++
 test/dm/Makefile                              |   1 +
 test/dm/fw_loader.c                           | 254 ++++++++
 test/py/tests/test_ut.py                      |  58 ++
 25 files changed, 1714 insertions(+), 425 deletions(-)
 rename doc/develop/driver-model/{fs_firmware_loader.rst => firmware_loader.rst} (95%)
 delete mode 100644 doc/device-tree-bindings/misc/fs_loader.txt
 create mode 100644 doc/device-tree-bindings/misc/fw_loader.yaml
 delete mode 100644 drivers/misc/fs_loader.c
 create mode 100644 drivers/misc/fw_loader/Makefile
 create mode 100644 drivers/misc/fw_loader/fip_loader.c
 create mode 100644 drivers/misc/fw_loader/fs_loader.c
 create mode 100644 drivers/misc/fw_loader/fw_loader-uclass.c
 create mode 100644 drivers/misc/fw_loader/internal.h
 create mode 100644 test/dm/fw_loader.c

-- 
2.55.0

