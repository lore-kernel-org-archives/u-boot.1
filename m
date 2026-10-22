Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43DF606A31E
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 19:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OG/8XyZv;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y8y5LD+7
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A81381209;
	Thu, 22 Oct 2026 19:41:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JXilu5Vr8fDP; Thu, 22 Oct 2026 19:41:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 42972811E7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792698069;
	b=RuhN75pDP9mjAVEITSO+301i9jBXXMqMbM4IaAtxpBblSzPnaMxpWWFvyQOLAVCk1EVo
	 Ao9aPCLcl748MPC3f6FrlG2+kyvJjXePjHjTMdQvM5y3wtDuyNPNS7x9v1TIo5+5n49Aq
	 ABkAt9P13uht/J4z3lrMh/QL+jCY3VVHx9gwEH3RF1rFf7+T6HiDHxnchXK6ICtIr3S8+
	 dHcvw2CWvjhu92QQUIuC2fvcGjdPrC9bXwfpNeVAZo6qDitHH+bPDZzTit/LvVgLWpvFJ
	 JZOPYdqdZe4K0z1PMFLr4xShu3PckP5TckBt+pnxznLFMtCBjsWWBtsMUVI7L3fnaNA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792698069;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RPk94dyUI1nm1tNoKRruqmWeupZzeFhuRm7oEwwbtAw=;
	b=iWYaubuBCkp62zfSPziqIBkRTTt7mR/ZzoradwNee6HNk5/HMPjcPQtso8cD7OM3+o2p
	 6QEnH3SUIXC4jpnfxdRIWMP+6rbOCjdY9FavE5nnkHeuMgxfwK1BM78W9gFiS2D+qk9wL
	 lvuj3EjhS2Bqwx8rvbaa+UU4j7wZ/HJMGtP1bsmcy1M04An9mcBXGfoKvV41+swVCpaEx
	 5Jvu0iMgSgQTPeiZq/zL/CVQnW2YzuD8CoWpdAZfUGyLLqbeR3zEQbQyz0zGIniUkKdIJ
	 0SfFFHuGTYcryn7bvPMWPD+QerkcSwYEZrINmWU/pYx/Rrpu8PAtIYLJGQ/8L6IZVEA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792698069;
	bh=RPk94dyUI1nm1tNoKRruqmWeupZzeFhuRm7oEwwbtAw=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OG/8XyZvOsK8LNuPssGN59mJdCOD48Mf46B3nSFDehDNDTsLw7F57/UEJoaY6wRtN
	 QbKV+x8Nug1bESiq3uzwGKtfeZVRNBkkW+yNR6NzsjTxFwpYZo6vdY5r8OB7xYobE1
	 raIvFxgDDLfyGkwE2+e1kDIo2FftwRvNhbZarWUgRwBioWx8cacivGcLJVtU1eEHqc
	 kON/hp7GoY0yEFPoCyNkcGkIkI42iG6XOtFmmc9wHo8c78Lj4JY8EUnp+OCQxP+6nv
	 NdzPC8gc6eJOZRLXgK+lpmqbxpvi9CCsOkI0sVnHaD6GkAPsBrTDNdoA5caExTvIYV
	 +ttus9fX31Raw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 42972811E7;
	Thu, 22 Oct 2026 19:41:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8EC233A7
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:41:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8014E6068B
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:41:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lIVDa3CQRF1B for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 19:41:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 232D06062D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792698066;
 b=JiL2nDWu/k2DADFV1r5l2SdqManYhFBRssY+VjA/jzmgHHBvCm79B5w2xTJBkE/ra4pN
 MCJL617cfhvAsOXvYhhK6yg1XedRcbEV563jxwquj8TfYIwHzKXFWEwaVJtqfL9VyDFcL
 c9G7FLo+tmPl0dO5gnpsr8AzEtAeU6dMpKWwlb9pFPbKhoUytehpcANGtWhUn7wEx77md
 uY3yNZ5lxG07ySQ5TnKhXo2gpQ6HFcJ4vHzA5APPzktka+WYq4l7OZkxBIJZf7NRxEgyi
 TCLX1hUhScdv3OKi0FK730/tXML0b7xJu1tJYmso4GcHPjsD+s5KB5m5IHIV2vQAPRg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792698066;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=RPk94dyUI1nm1tNoKRruqmWeupZzeFhuRm7oEwwbtAw=;
 b=tJ9tPP+cv3/+6DB0mCydYdhQzrJ/9ybfoUDExnQtNtom7LWzjH4CPhQoyLaZGzCfb6VH
 nqYHwySI/k36bXW/2iqkk3CMfg8a1SLfjFWktA8OSwwrQO9pAOm/r1j9lCl3FGXjuiI/1
 8Df3P7MenpivXXEUR/tqctEcVhlZmMHkBB0ZDlyYq+kB/o5AC+RZx2gyLFZuk2Cs9kUQD
 M97cGdcLtJoBjI72Hbh2E1AQAtH6W6yihp6LVXTTHujqGs9gl3yRmjZzxxpTbHWKyHGfr
 ryaVvo+JcUIQ6TKbdOmKtpHSGzvEiMBTmPC6S+OgjC1xKTvNy2wrsBCRRkwt4ewYN5Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Y8y5LD+7; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Y8y5LD+7
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 232D06062D
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:41:05 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a1fe9efc0eso1366275e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792698064; x=1793302864;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RPk94dyUI1nm1tNoKRruqmWeupZzeFhuRm7oEwwbtAw=;
 b=Y8y5LD+7tL81ftZxtMnWIik/g2pK5Pub+jlv0em+9K1bu3qPrYsBj3tYm1rUwKDT7Q
 euexc3DiPdeLK1InK2TEVNxfnswI/qQ7x+jHbWatinw8DPDxV+vZgg6a1o0ZUW8iOwSK
 tb3u/2ULRLn97oW++5WMPcuwsRX+CRm3Q5fucGGXpJ0TWeV8wXSCsKW+m+OKLFd1tNxD
 4gpFqAKS3rU5F/n0rnhz22x3cRuECb5aXd2SrjmXHZuLvvEc+dToerbcwOboaE0O0hSB
 n9rfKZ5sAE9KwpMyZHqta5NstiCGjWvv/4UjCEbtBdUW4woTHtsKGvOzWz6Kx4Gokw0C
 UEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792698064; x=1793302864;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RPk94dyUI1nm1tNoKRruqmWeupZzeFhuRm7oEwwbtAw=;
 b=x1xoNN+6dRGWAUvZXr9kTMk3mpkgc47QCsc08rWN1FexqzQoAPhqmxrLOILSUyF7Je
 z4IizUM2QvYAtbXpiBjdnCi+z4DYCIrve9Zn/hfMc4xM/Btm41t9zZ+Q3CXxmS++m6Uo
 4RqK/nYVKu+RVL8SXnsSmBqboAA4YqXvY10WCkhvJ1GUKvxbPckY7mVXHYlGX9m0JIVL
 dX4c52pZkVILCwOiOjiwUWFjgZcYaZ8bcsdzOFBWgcr/9yfPvxWKX7DowkG5AhH8EPFe
 nSDgpXdrj1g7z8BLCBhivxePgH01ocv3TtolY6SuWaxg18oZAhUiQLFCYPMYqkOy1YmY
 5SBQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxbIHKaAsMSgANt6Z6tZ7O1IWk4x64v+uOSH/PSQB6NWzgL8i51x8WKD/kDbgXbeyJ5TfUMvQc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ1LXMpXKcmfEFJQ8+h51tpUXfwnf0UDfqdUJo3k/r5Y9UAszqC
 ybcLf/m7HWrlGf3oI+p2lWYeinu/zN5DIs6J573jMpInDCIbnlDAPcLu
X-Gm-Gg: AYBFou2wVL3lLx2aMxOpZKlzJbi86QcCfcQXcpdsytp4iushUFVO4107TMfj0k2TMod
 VdNJYJpYWRKG4tZHivj2Zv3kraxO3kvajWXt0OUgPsY8H3uCszZwdwMhMDe5GIo/dKhiXqyv2kn
 FtUJv/K+ibG5Pi4DjXqJbJzmIhaoer0nzkMvqRSuqCygJQQZ/RPsTdol9bjeGO44P/dKFQ1BdLU
 8T7DW4eEj49kZpIC6vVN0kgZhpMGKVXoZHqKYuGimr2q5ASk6ai7czh8aLdvOf/vJgD0WwBwfSw
 U46dphcZYJNl8RLnN4TlcKxGBu3DfnamEKLWKw1eG3zTHW4uiTeM3Mo3a/8/ERGKv7goSBN0gxv
 E70twWUa2aqRqYRsb05q1YRxkBNTvPta12N8WQCysDLDv53tUAsoFMMDpQnwUKq9heINcN1s+eA
 3zvF2y/tKOR3Q7Ran42Zyla+DbuPDo6gZbpKRoJ8spOg687t7eZBcyrFufSyhe/46NRjg2vRRb1
 cih+xFNS9BuBFiINvuJKWiAyWyf9xG1kJYpSrSfjYyiZpveJ/Xl2gfCeDrVxBtocrOftRqt08Vz
 PKimPDzqd59A856PhpY4d9HPrPt8mE9eqzpGiuuZJnaLOr2Yo8nfzRUMSb/Zhw==
X-Received: by 2002:a05:600c:4341:b0:4a0:c02:938c with SMTP id
 5b1f17b1804b1-4a211ee1f64mr776665e9.25.1792698063501; 
 Thu, 22 Oct 2026 12:41:03 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4a211be8f79sm3185715e9.14.2026.10.22.12.41.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 12:41:02 -0700 (PDT)
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
Subject: [PATCH v8 0/7] misc: fs_loader: reorg and split to FS and FW loader +
 FIP loader
Date: Thu, 22 Oct 2026 21:40:35 +0200
Message-ID: <20261022194049.670889-1-ansuelsmth@gmail.com>
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

fs_loader0: fip-loader {
	bootph-all;
	compatible = "u-boot,fip-loader";
	phandlepart = <&mmc0 0>;
	partoffset = <0x100>;
};

mdio {
  en8811: ethernet-phy@f {
    reg = <0xf>;
    firmware-name = "d39d2cf2-9bd0-3ca7-93e9-e71b4f9250b2";
    firmware-loader = <&fs_loader0>;
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

Christian Marangi (7):
  misc: fs_loader: fix ubifs not unmounted on dev_get_priv error
  misc: fs_loader: reorganize and split to FS loader and FW UCLASS
  misc: fw_loader: implement generic get_fw_loader_from_node()
  misc: fw_loader: implement request_firmware_size() OP
  misc: fw_loader: introduce FIP loader driver
  doc: dtbinding: Update documentation for Generic Firmware loader
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
 doc/device-tree-bindings/misc/fw_loader.yaml  | 126 ++++
 drivers/misc/Kconfig                          |  31 +
 drivers/misc/Makefile                         |   2 +-
 drivers/misc/fs_loader.c                      | 326 ----------
 drivers/misc/fw_loader/Makefile               |   5 +
 drivers/misc/fw_loader/fip_loader.c           | 556 ++++++++++++++++++
 drivers/misc/fw_loader/fs_loader.c            | 220 +++++++
 drivers/misc/fw_loader/fw_loader-uclass.c     | 231 ++++++++
 drivers/misc/fw_loader/internal.h             | 100 ++++
 include/dm/uclass-id.h                        |   2 +-
 include/fs_loader.h                           |  47 +-
 include/fw_loader.h                           |  42 ++
 test/dm/Makefile                              |   1 +
 test/dm/fw_loader.c                           | 218 +++++++
 test/py/tests/fip/test.fip                    | Bin 0 -> 101 bytes
 test/py/tests/test_ut.py                      |  26 +
 26 files changed, 1613 insertions(+), 425 deletions(-)
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
 create mode 100644 test/py/tests/fip/test.fip

-- 
2.55.0

