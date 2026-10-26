Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25C4606A31B
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 13:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Yd4zTghl;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HSqx7HRo
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B4CB760624;
	Mon, 26 Oct 2026 13:40:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WBmupt7oQKYR; Mon, 26 Oct 2026 13:40:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8C16E60600
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793022019;
	b=qm55ZF0HzU/GGMizgizh2qc0XvvC2z+3LDWGM+sRahpP/lu7hS1el9/KmapJWmtPyGZT
	 vid9mLOLoNzcOCuLYMm/wtd2T0M6xN9J5Vht029uxQ9hQZhqYo/n7x2S39zqmr5TjIRMd
	 4gvT6B4jHaLynMcgwMeyLOrkHBwbAWqkMajz/mIaqPHry0u+7ls4BDvzsSsWQFRB8+F0r
	 BM1RituEeSkQXxE47OyuEaRCutX3921Ggd1ypHBHRzZ+/tINiQINUrjSYLZcDWypV6X5e
	 mY6eFiUOsNdsAF+BfnJ6h4tnw1thUJcY/dcgqrrp9jV3p6kzqX0XHlDMT7MnKmlDyXA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793022019;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kVISLLKAv63NLfsas3cS9UwzVVG4tLOE8oPPaNS0UgQ=;
	b=AXy0KYNB+5PDRd5vh8TtqpD3YW1g4tSv69Ts6+twqE2jGbSYtjAFfV7c7LMNbsOkF90u
	 M9B8GFR1Uy2Fmd75vh0GgNp0HvIFWYVHt2EvI0yyYQ76tksF7CaMMU8CNtkVMww8XkxNv
	 ReGvOibVhOYiOrPehmgYLnNqnSq/CIQspW0bbsS98TcvTEFx6I/d8i8IVipLx7d2dXca/
	 6J1/mmdXXl9prf/HoQZIwnYAz6yKLdqMnWnjdyC1Zjc0AACWRGjDkTFOoS5jyGToQsWgV
	 gAEHPRIbz1Z4aNJlKL3iSfVMKRGtMhZJxgwIR0VmFWiWLU0bl8jwT2COQ1JTkiCTM9w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793022019;
	bh=kVISLLKAv63NLfsas3cS9UwzVVG4tLOE8oPPaNS0UgQ=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Yd4zTghl+h4t7kzUEZd4Dx+BSXgU7W9MKMqj2Mh1WEV1mZV+nO2mlBRwP7wIAhBG7
	 A1AVElMh1TViJaxcHdmP3FBC/P2cjRVZGHwu8w88zF/uz/h7zI0MXiBQ6HsYj0EVOU
	 /fCxXbK33ZwI4iP0BYHoUnPGSpDRBkNklgLfg1oMTej8pc4yQC4IZVLh1E3aKQq7K6
	 uLeccjCK6eMQleYC3yM9Gmr6Cd+7/OEAQ9qd0h+s7zqBA/c5ZmWXLzTyvnq5+BGMx7
	 srEJGXsdF3QZBfsfI7LET7XzPY8mrqnk+QnO1JoVzeq8FiNtReyP6YyngRD1VPHFJd
	 +4qZ0XriNyWIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C16E60600;
	Mon, 26 Oct 2026 13:40:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DF8ED356
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:40:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C597180CB9
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:40:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4o-lk0H3VLgx for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 13:40:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 86EDF80BC0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793022017;
 b=grjjOTwd1P7sa6mqKAwMQGkVCxHjx+V8QjG2kUUMrjW+Eko1dNzRzuM7nuT1KcKE/CBv
 BFIxN64i2GDvLmYaCPCLagiD3GErMIHugeEmmadHeTxgFx41U3n489Y0skUM0xMCl7gba
 +zsJINjOFS1F898DwEFr9U8Og498sh50ZlPkecqnRTYgh3uyzKqPbgp8XhV1MDMO8nExz
 mqLKtYzuYLDneIUA4okEVMEnKJl/8ERl5CyUjncGaJ/GcLQbPnDmkJ7drsAYIgcW1/ddF
 kpGs+XfzwpDYwGXbKVmJuzTsLwa8yw43S/MSwTH96P2gXWNlkeBRr4ovtoVfsng2FQQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793022017;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=kVISLLKAv63NLfsas3cS9UwzVVG4tLOE8oPPaNS0UgQ=;
 b=GuZjvFquWQlSUbYp1vhA1H3c2bJTc4AaEq3epqR8E6W8NxHY0NGFM1QB4v9GQVPyc76O
 6Yr2R/XtpkR2PC3/GQ/8B1lsiqWlx5NrLTkGIh3v+DYuZIFESuiO7Sl3DZXNUHDBlhMJq
 8pY7jpWjOjNxKmexGSi3iQFGzzcncK/cvl0DLXeENnE3cZSEi9Mj7jJeX8RiULBGJrJSP
 4zbSOOFzIsBbYVIzJmz/RCOQKk0xPazKiJJOiK6AidI7gfaGJpD9bE5LyTVv2P28j23yS
 KqIYu8ruMezQR7dkxHSNqvTw/SfwksPfYFa1waJV2MtB17DKyev92ZQxeyC+YDBVIAw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=HSqx7HRo; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=HSqx7HRo
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 86EDF80BC0
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:40:16 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a1df4c0966so19661735e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 06:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793022015; x=1793626815;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kVISLLKAv63NLfsas3cS9UwzVVG4tLOE8oPPaNS0UgQ=;
 b=HSqx7HRoxPgEyAiRyW3vE+ebSdZs0hJ4hBq025QAmTYnaenLNIFmjZfCeHKRJOhNOe
 FNH7tNYlYcial0Uid+HCxh6Jua/zZNHxFoVB4E/BbnvYeCxOYbn7683hSruzZA65Ci4a
 oRqPXpWoJCM4K7ORxwai3DFNA0KDQuFt7aIyCYB+F5zs4IE+d6scwOL/t857hHLNaJrQ
 BMLYjRAFB7gxxqI6j4tU85pgwb7gDAGOKnf1wKdxDBLyKsMPcHa3wKkLdhhUKhv7OEGG
 7pReT7kI1DPUkGX+dDXC0Eud24ocFWexL6GpfnNy7pby6fxGWMiO5+XOeD+orD1/kE75
 gCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793022015; x=1793626815;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kVISLLKAv63NLfsas3cS9UwzVVG4tLOE8oPPaNS0UgQ=;
 b=x9wfkKcv9mhVsZOfMnFev0Bt1tTXxRdND07aCZn2Lc1ZwtMKk/TMsjtOTVutxYVsoe
 fK/1CZpRceVHh39agsB1J2SEY6hBAJcrVGdajeUwmPlRFRZFsqOVZmaJzO1Bf/+rCGBB
 RDvsxaTfkaZhJCsvJVCnUvxLXwLs3Grznh0shfSsmwFH7Wud4sFQjgp2CBmK0CAdlGTc
 raRki8qK3r0+nrvsFGN2c5OR3ZQ0uvP2wR5Wuh1hJYLTAN63VOmaIYmonH0CfeiVVdn8
 wvicj7k8rMRzqqsJxZfOS+vHEjih0NsH4QVSIO+MInSGQ+Wn+nGCdShNw2a8/1sf7ac9
 sQww==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4QpkF/pRZxoVqwoypYmsLd01EKQopQyoDzLXozugHvOwYXcfpIbDcSoF53YcDpzPwTuznBvg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIobqCFbmL8Gg2Lx+RIA35HrTBf4SeGq3PW45y08l0wt9/nDAES
 A1cDp+PCjUZwja9pzMnr89Brfuwli0FsHOklWTY33JFiMpN85KsT6fSY
X-Gm-Gg: AYBFou01Q6DF0ZzcQ6J8OPXjB1swUXdvgEryr09MF6AonAy11o25Ssti3S21rnhdztl
 /hMPOrNNnBmOFjXhGzpkPhFzqikdH+BrQluZajn2u15xsddxkpFrmmZLozjpkeszuCfi9iI3J4E
 C1sQz1Dh1jrXzQvcBvhf3g1W8tl+ea0XPV/tGg99N79SVNj/Jp4YkAi2OvbmDYf6HddL2kwaBrX
 p0/VeJ2yIeEW2zDC/cY36kmGdW/VK882pUVipNj6uV44kCao9oXRhYwsOBriWp82w6rBybFnOQW
 2kJtowWOiKs+xebCzqwlQGq5kpHhMKXBavok3IVNXu/fQ5nvuH7AJGKGB5eVhQoNzTf3KYnnFUa
 4X6w/lskse65vnxgrPGfFa4NOP+7Mx6K5KFybaTXVJxtsBipiX+OLZnN6CUVIS7qeNACeo/QzMy
 mCIwqJ7QZnhSi8+WfPvYQ/vE6Vkf2xRJVFagMXBIzV/ZJaGvL95bxdbaXck4H5bkASd7As1J7z+
 ZB/ovXBRGelK0CtpD+NOrfC56j7PkWqSLiKUJJHY0vsRXWSxprYo5vtv4WU1DPRSPWsYFHh78e1
 /hwvr1Zz+5xAUsCaFTUzwPk1Tfi1GN4s5otFcByrrmBjpUiXRjIJIJrXBAzP
X-Received: by 2002:a05:600c:4f05:b0:49e:65f2:db64 with SMTP id
 5b1f17b1804b1-4a35ae71b30mr144107835e9.5.1793022014687; 
 Mon, 26 Oct 2026 06:40:14 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4a35a2c0458sm194344375e9.11.2026.10.26.06.40.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 06:40:14 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Alexey Charkov <alchark@flipper.net>,
 Daniel Golle <daniel@makrotopia.org>,
 Pranav Sanwal <pranav.sanwal@amd.com>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Tan Siewert <tan.siewert@9elements.com>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Randolph Sapp <rs@ti.com>, Martin Schwan <m.schwan@phytec.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
Subject: [PATCH v10 0/8] misc: fs_loader: reorg and split to FS and FW loader
 + FIP loader
Date: Mon, 26 Oct 2026 14:39:53 +0100
Message-ID: <20261026134002.109025-1-ansuelsmth@gmail.com>
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
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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
 configs/sandbox_noinst_defconfig              |   1 +
 configs/sandbox_spl_defconfig                 |   2 +
 configs/sandbox_vpl_defconfig                 |   2 +
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
 test/dm/fw_loader.c                           | 218 +++++++
 test/py/tests/test_ut.py                      |  58 ++
 25 files changed, 1673 insertions(+), 425 deletions(-)
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

