Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBC6606A32A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 19:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Z+BSc/a7;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bIJ1yg3D
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7FA9360A3D;
	Fri, 23 Oct 2026 19:00:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lv9g2rc9trJs; Fri, 23 Oct 2026 19:00:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 44AD46090B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792782046;
	b=e7zfpKlesNkidDBk8Rf0ncJYvjRvgkUmdpNFeajajPsJw7qbpdMOBEJABXEwdqesU00W
	 teRZCLyCsAOWTTLHEcgZB4wKe19nMBBE/3smArFTMtR7DpJh9B+WYFB8YZ/L/5EobsrN2
	 URil3vBPnzP+wmxPtoaSa7szuVLuE0p8iuKY7b3LTFHxtrS1p4FO1dm/fZX3V3fxmAPlH
	 k5fZsMHIU+jsoUHZ+VHqCuPFoXP8ARkjyY3HeZbtdi9cCYRcIdOj+L81R5Hqpo/3Q9WUj
	 P1EX3gSNYS4ViOn+jxDTFebteB/QZbEDqQ2ML0P7zgHWhF9tsgYLnGdojoouLZpwZsg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792782046;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=AS7KMY/inXJFPjUtn7kE4ZSZ1dxAEeJxLrGE2P15t0I=;
	b=XkceJu8nsTJuFjsoFzmN1+8SNB5FI9kdnaIojyEbHeZPb6cCHPtOi/AzlLCyjvDc2P+X
	 2wldfPFjlXmF8LfLZ1j8DvOCxpxlXbyOxHsbqL3WxfqMBaexnzinelpEBCllOPMUqCkgt
	 IbXXueiPWu44bsR69dgdfDm6EI8L3r4KwnNoEFneMl52l5feslxGfXR/hXw6hLpUrNXnA
	 LUh4GCYFIjlzSvvFKs3GYd3nXN6/HlPSZZ33BWnlxUUITfAGuNbrDySlv1xcNkWpI2fkB
	 SzJZcuGkAIERRc6H5vuJJFfkliZzK9d4Sm1jFWljqCmWFH6h5lj0SxwT+oTtK26QgQg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792782046;
	bh=AS7KMY/inXJFPjUtn7kE4ZSZ1dxAEeJxLrGE2P15t0I=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Z+BSc/a7Or/o7ijr09naVCyNfFz+EFUEjKPVe/Gs5FK3ImUj/csnQ7A6OM7OxsXBH
	 ZhB2gco7X2299rDGqOnTqKHiReL5FyREPTdeG6A6I9L1tv0q5Dq0oeFU5NcRBfUxIR
	 E9Pl2HO9Wbdu9bB4ggJ/DUDPTzxJ1uJWD45a7WC5v9lL4VpsGDrhXjKSsFyLNjhvqD
	 LDbOmuhrLplMq3GAw+tdHPZnzIymWWEcpALuJpwym0qF8UhSP6BIOLIp3gnub8eCJ5
	 6MPAf3m9F2Wdvcra8KLmhUegzRtexE15TV0XjGgJJwb8nw+JP5ke315RUcA8sSNono
	 AsMJd5/6rFIfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 44AD46090B;
	Fri, 23 Oct 2026 19:00:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7CD8B388
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 19:00:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 62CC44007C
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 19:00:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O5ZzVuI_LupV for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 19:00:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 23A9E40061
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792782044;
 b=XkOabCgBfTA805S6KH0DoymwFu2W4xAFHCjS6licflhU0/XhA5LcTupF7vhibL06PVOc
 H1e2jVJa7btJYkkM02D089uiIs6JTAiA0YKogZxwASydjMwhGywFjPxyxlVpMz7EoLPWu
 MEIdMWCqiXYlDPx87rglcsJf9kcZjrrcW7PLjuOT5Mi7a24WGPYBpCsxOR0FnWKv4vOvU
 Nve4OEBij07sAIsBsE/AJbB/+jn9T+Nxm29zIOaqomcrhBHfv6dS5yTtXBebbISOwAO0E
 Lj/BVPoy7ZthO24YGegZrVwqefmVVrAIWC9FgLLkRZ1lQA1OsOpiDktRMBpca0vSg7w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792782044;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=AS7KMY/inXJFPjUtn7kE4ZSZ1dxAEeJxLrGE2P15t0I=;
 b=RD8uZqHGWlsHr1QvBfkdkSHuWJ48iJai58u1eLZXxI3bgPWcqItwo6RfWLxMi0RB4lAu
 YxxmfS7oEz366lnNKCl7AFH6klmVj1x/JcvfgqfUjmoJKvkc51fzOc4ki38hM1mzT0ZQr
 yyhvxPuusqS393gJnAfsm5VOwSnB+XnJ20d0jvMwDf7XDQXU9vXTkDCeIlNwKGFhXmA2U
 5yJ/2YMZB0Bykx9fEE5vKuDvtNuoSd03iAfckm1XpHoGDy9T5V4UDWw4syi8XlLwlkR4z
 78D9dj50KvR7rVr4ZMoKHyQCRlqZDoENnWsKYDYD3fJ10yxfGttN/aix3GNCxYJoc5g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=bIJ1yg3D; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=bIJ1yg3D
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 23A9E40061
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 19:00:43 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso11901395e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 12:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792782041; x=1793386841;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AS7KMY/inXJFPjUtn7kE4ZSZ1dxAEeJxLrGE2P15t0I=;
 b=bIJ1yg3D27NdyEAV1FNmSiFM96wnd+PriECkuXP0EHJbuWkyTX9+szAThtPaWEfcO9
 u/suCTJLZ+pCSmLU93AU6Lc6DHELavU+u8GLHVUJ4CUC5DxhERY80O5hpfa22rrbtV5q
 SecLs/x+rFHJE9dYVI0mgqKNhrCLU/EQ2eF6l69HOghiCkJg+c+NnRw3NIB0TVjn6T/3
 g/IVMA0x7lZF5aBYcprXHB+O86bL9gouIzcmVIX8MQ/uG8SHVwBGC2E5oB49HB9uZuep
 WxQ+LzJAfVGMve3pRV7sEdMnydbogojJ76JTXbAIMDJo/uGB41M62qwh/CyfTGYHl0Yj
 I14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792782041; x=1793386841;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AS7KMY/inXJFPjUtn7kE4ZSZ1dxAEeJxLrGE2P15t0I=;
 b=Xt/B1xLfUGlKTAQ2v7SStSt8ZI9bXJvpQ+yAgW3IRFFUq+Tv1angxjQF8fpznWcKIN
 vbaHkGbb2emCkS4doR+X3HeIRt/noAnrukDBCuEi/FgqRPIA8Guu6+4mm32JiQlrL8CO
 Z/xcMIUi2eDfQ0yhHvfLwkDDT97dLIN5CTNhXCjTz+JYJ+4A1NQwt/x41wFpnxcwXyeB
 FkLa4HEtSgX4m4DMdtbKi/kEQ/8Mo5Mpm0kw2u8KhD4cFjypv6OE0O3/JGmUOtfLTUi6
 fi/jLp90LrV/KBBuPL6prq2Fu+nXvk3ePQ0B7pxwr8CjYaXr5ZoBvKUYPfkafE9GCTDf
 VyBw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzHt/uXSP5hu/mGD7Ro0duZRHCGttczx6oFzEoyA0U/18hqetpPdb8eDK2UVtt01bq3+ZQyaQs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIOaeYgIKiDTligk/w+gYBS+LlUhtgMVgpUrKD/EkGH4oJPTKL/
 HehL2+5sx1/a5HX5i+IdwBt8y5zEhXTTWi2JRdxc0+Lz+cQ5Mtl9YDg5
X-Gm-Gg: AYBFou1VO+lHzcO21boMzxJifFfORyJrPiKxEt22cG4rXehekp/A7zFdJmlPsICghaK
 Hq3i6kHD/o22tZaQd615XbjucGDABpsA9Oe0gA+gq964oAB64hZJqejeyg/C4n60zTqjsCtYTNJ
 /mICENPzC/4RKonuoSFayGzYdXPpfCBxtWUXKwDSZZn0Hi8bNuJsgAbwKpoaVYe76Ht4sh8/gcq
 atSYAsH2zXMh+fZoZ/hQ2gsSuqf5j0zZFEqRnxhOAdAa/vX1vaARAyWvawek76gr3qrx9yvvINt
 bF63MEGF72+g2YFWapfBGOPEcB4khMdkiqKfadt7GZa0pTRjAb6uczD0pztN5zkasbgsQ+IJ+j2
 CNVWRIoB3DU1cDlF80C2GJj3pVlbrlIrtUn0U2QNi+ULEbGze0IstQrdaPrCNrQpPp7yq1RiGPt
 +aQd+F+Grt1yMCUsRsR4zQ0QX54duoZZPnOfxIF1scVYnJC762J6CC18XhNUy4mW8jwW7OjIH4i
 wHzRFursn9k8EecuL7bT6S75B0jFEKpNNOiHXaT7601OCHuVMBzrFD5GWNHejH6zAFonVSY2sDY
 9W0F1uP3UGg0aAln4vC8oFvykDT+jIHSKpT6tWar3fOPj3M2ihBoGikYItCsKBl1XzXERID4Wqb
 /faTiBw==
X-Received: by 2002:a05:600c:a00b:b0:4a2:1a:a122 with SMTP id
 5b1f17b1804b1-4a211c9c5f1mr49346665e9.9.1792782041317; 
 Fri, 23 Oct 2026 12:00:41 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4a35a0aa097sm2481275e9.3.2026.10.23.12.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 12:00:40 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Alexey Charkov <alchark@flipper.net>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>,
 Johan Jonker <jbx6244@gmail.com>, Neha Malcom Francis <n-francis@ti.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Tan Siewert <tan.siewert@9elements.com>, Yao Zi <me@ziyao.cc>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Randolph Sapp <rs@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Subject: [PATCH v9 0/8] misc: fs_loader: reorg and split to FS and FW loader +
 FIP loader
Date: Fri, 23 Oct 2026 21:00:21 +0200
Message-ID: <20261023190034.911023-1-ansuelsmth@gmail.com>
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
 drivers/misc/fw_loader/fs_loader.c            | 234 ++++++++
 drivers/misc/fw_loader/fw_loader-uclass.c     | 231 ++++++++
 drivers/misc/fw_loader/internal.h             | 100 ++++
 include/dm/uclass-id.h                        |   2 +-
 include/fs_loader.h                           |  47 +-
 include/fw_loader.h                           |  42 ++
 test/dm/Makefile                              |   1 +
 test/dm/fw_loader.c                           | 218 +++++++
 test/py/tests/test_ut.py                      |  58 ++
 25 files changed, 1647 insertions(+), 425 deletions(-)
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

