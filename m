Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C01F606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 08:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YSQWKNDc;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=LH/XMTZF
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 28E9880F7B;
	Sun,  1 Nov 2026 08:03:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IP80zNXwjRCH; Sun,  1 Nov 2026 08:03:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5F509810D8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793520201;
	b=s0unpPVpQPgtBWgWxFlTUPAIDMryKlbygo01kGMNO5YlX842qATstVx1DXHzoXD2J/7y
	 Mfpci1aPT3sWpHFpzE6MejLn2jlwy2J573bT1WiZLOi8JnWHkJUg6Dh4HctiGyrnxU3HX
	 bsy0fTBe23OyghkY3Zjm0lGG7PSmV+umdo1QYi/YjviEnm02JuCgIvpH7WkGk5pWOHqtP
	 x1uC+gNhxJ5g4aZQFgVoGq/i2RiiA8Ldh/9bzwUq5oVjcibai7fdqKsULvfVtyb0KQDM8
	 y00RJaTQGfdS9bG+ijhHJiCA6ZPx1q9ZcwJSRSbESr6Kknkl/b2TWx0K9JPelNDH+cQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793520201;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:CC:Subject:
	 User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:UI-OutboundReport:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rglKSNEcuyE+rMzyrtErg/ejrRhDUF5idd0iKpT3uLM=;
	b=dREXbljBvt7OG5BqPqdvE4ygbxrHzloRTwqkPLAg2/l37jW0cQUxEAbKfDz8yHGSUuea
	 f/h0cPl4sxQ+4zoWkuBDsnSGKfpVFSpwxG4IKESupJbk5V8qqhZnc/wHN2UcDgcqJTj9q
	 Fja2T7sIGlAFEkLWv698jQmPzWImFiy9gvfcwNp9FLDnjqPi66eiyQ3rx0S84iIBd4ThW
	 jrxeQzl7YPwxkU+21d01K6T8L7rZiFxQIpaSWKviGPn565p2CDjLNceJ6Euh1QGD9DWJG
	 oay2xVqEMuvpS39UsenFjqKIQgK40GD9n5tuF+UfkYGgM4SZXonIBebWLGdsmzs3n6w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmx.de;
	dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b="LH/XMTZF";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793520201;
	bh=rglKSNEcuyE+rMzyrtErg/ejrRhDUF5idd0iKpT3uLM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YSQWKNDc/lPZooYZh9bw5A4vvGxcIXcSiIA6n36BccT2zPeAUUaBCNcF8w1+qc4+Q
	 ctyDCz7gzObCKbd3cKIbBwYBbWmc2sICmo4JK1clLXa4H7lIROzEEANO7owFBMS599
	 /6H+uef8xst9pJeDnEgVj2kwjzG0flU/L/5QbvWmbEMRm0qwbHS0CrjPOY+1ywO/CW
	 RBJKAmV239eltI7h+s0f240VbLYPLfWRvIGVawCKPvEj40pmyz1tFbSdIrukixZfQG
	 z1BDm/aZ855tb9htEYAuBCGfUKmsLLeRKLb2eZjjAJrTCma/ztHvl/+vEoIPmJ7Wwn
	 rFGHn5mVbS7kw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F509810D8;
	Sun,  1 Nov 2026 08:03:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 40FAB4B7
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 08:03:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2285A810D8
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 08:03:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I8dbXzGoZalN for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 08:03:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A1E1180F7B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793520199;
 b=PblebFiPxWak8SexSDDFP1ZlC7GEXPIPssmX/NQOzNeG7/sKbgfzNn3HBqbU35a7DqAr
 xAYePjmxL1UNLqsTM8q5yBl6l9Fvvx5yzOmpO3XlLyUwm8+sA5YshP+Pgn9+STkyGyAA8
 oMkZSIT4cNSXRRnFxCIsEL+FPF5JYzIPDzeXyXThQzS6zKBoeEyze+lMVJBLtJ3iUCdSb
 CFkviKcxEzZnLSARFz1pWgVF0cu4cc9Dr0FebFms/V0LIlxJoNPZV+pvhNPwyPCayY7ZB
 OaLDiBCrHrEMaMlpV6o8ZR66wozgfPs0bH1VNons8crXQJDZ8DSvIJ6TWz+SO2QiYug==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793520199;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:
 CC:Subject:User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
 UI-OutboundReport;
 bh=rglKSNEcuyE+rMzyrtErg/ejrRhDUF5idd0iKpT3uLM=;
 b=tHMjTTQN+Cm6En3+5NrrhniVNX06G+fv07h34XBWJf7wDydPe7jq7WMGgSvNXnre7RQk
 MMkH/6z9UvCdnBPFBjdLhUel76czbi4mNNmV+7Howt49zaye9z868blQKvCc5ejvIHlBR
 WlH/cMrePozkUk9WM5mLeuulK8EJxSlVYP+RYm1V2nyOJoiMFi2FclUd8OIfBXIkmKjUW
 Tj2z9Eimy36ZAmdNtc8W/w0JHpbqr4NRU8no3rTAAUTz0YFf/tRYHEOiqn+nqqIAr/hcF
 lHGACLWJGY1XFCBt522WEWHuRi60krp0Tp767lfyGhTvUWsnZdQtbR2pOSabPg7ApPw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmx.de;
 dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b="LH/XMTZF"; 
 arc=none smtp.remote-ip=212.227.15.19
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.19;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=LH/XMTZF
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A1E1180F7B
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 08:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1793520193; x=1794124993; i=xypron.glpk@gmx.de;
 bh=rglKSNEcuyE+rMzyrtErg/ejrRhDUF5idd0iKpT3uLM=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=LH/XMTZFd4v6It89X6ullUs3v5aovctvAqOYHUhh0szdgV2PbJ/bt3EXEZTXJMdX
 nCHxBw/wP28TiXr3z0lXbGC/acQg4UURzhBhj5hXiZVMggFcQOQNXHj6zu/27D8cn
 DNGHki8taehiIAgTuArqigJXxQi6nkpIDfjTPB7HXvo6KQPx0GSLEyEJE1QSKlU0B
 XqxcR01ADUU5JrCHsrgyTySVjSO/CeqEqYuY0VHe88/tu5YJFvSktFDIWyet6sH6n
 138LB4gho+a/pcMgmxYaSGdYCmH25ceBt0/KhugADB34knEZ07olIragRqcR2LpY3
 earzBAnC6wZVfdcP0Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mt79P-1wYuPg2JdR-015y57; Sun, 01
 Nov 2026 09:03:13 +0100
Date: Sun, 01 Nov 2026 09:03:10 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Ana Bobillo <anabobillo3@gmail.com>, Tom Rini <trini@konsulko.com>
CC: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_11/14=5D_disk=3A_part=5Fdos=3A_Make_room?=
 =?US-ASCII?Q?_for_a_three-digit_partition_number_in_the_UUID?=
User-Agent: Thunderbird for Android
In-Reply-To: <6de0ac6c-e5b2-4776-9c6e-3ebd371dbfa3@gmail.com>
References: <1ea4ecf3-70d8-4469-be94-1943ab8e3337@gmail.com>
 <6de0ac6c-e5b2-4776-9c6e-3ebd371dbfa3@gmail.com>
Message-ID: <12ECB91C-515F-4BBA-AE32-A6654D925C24@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0O/8+0jZ8UOPaSZK4iMzJ5xdB3+T+aYY41pb1ta4olx2UlnkJsz
 n8GT7kBbuhMBQ1/OKauBBTlyzXyKXiSict1mW4sdTvicYIro8V2hMpecEB6o7t3eH5g8cI8
 pGbkfVoAXNia88NrylGf/L4aRXUPnB62zNbNQQ+xOco8jvP+wt78uzRXmlHA7XpUm+kgm/E
 KqCgyKgm+Q9zKMFZL3TSg==
UI-OutboundReport: notjunk:1;M01:P0:oifS1hyAjCE=;ujFwHu58dQchoHm/cNWVkdGPIGK
 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
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 1=2E November 2026 08:02:50 MEZ schrieb Ana Bobillo <anabobillo3@gmail=
=2Ecom>:
>From: Ana Bobillo <anabobillo3@gmail=2Ecom>
>
>part_get_info_extended() makes up the UUID of a DOS partition as
>"%08x-%02x" from the disk signature and the partition number, into a
>buffer of 12 bytes=2E That is enough up to partition 255, but
>MAX_EXT_PARTS lets the number reach 256, whose three digits make
>sprintf() write the terminating NUL past the end of the buffer=2E
>
>Size the buffer like the UUID it is copied into, and use snprintf()=2E
>
>Add a test with 256 partitions, which catches the overflow on sandbox
>with CONFIG_ASAN=2E
>
>Signed-off-by: Ana Bobillo <anabobillo3@gmail=2Ecom>
>Reviewed-by: Simon Glass <sjg@chromium=2Eorg>
>---
>(no changes since v1)
>
> disk/part_dos=2Ec |  6 ++++--
> test/dm/part=2Ec  | 46 ++++++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 50 insertions(+), 2 deletions(-)
>
>diff --git a/disk/part_dos=2Ec b/disk/part_dos=2Ec
>index bc40d9d2829=2E=2E3029ee0c31a 100644
>--- a/disk/part_dos=2Ec
>+++ b/disk/part_dos=2Ec
>@@ -325,9 +325,11 @@ static int part_get_info_extended(struct blk_desc *d=
esc,
> 						 "0x%x", pt->sys_ind);
> 					info->bootable =3D get_bootable(pt);
> 					if (CONFIG_IS_ENABLED(PARTITION_UUIDS)) {
>-						char str[12];
>+						/* part_num may take three digits */
>+						char str[UUID_STR_LEN + 1];
>=20
>-						sprintf(str, "%08x-%02x", disksig, part_num);
>+						snprintf(str, sizeof(str), "%08x-%02x",
>+							 disksig, part_num);
> 						disk_partition_set_uuid(info, str);
> 					}
> 					info->sys_ind =3D pt->sys_ind;
>diff --git a/test/dm/part=2Ec b/test/dm/part=2Ec
>index 4938d962144=2E=2Ef8a0fa974c1 100644
>--- a/test/dm/part=2Ec
>+++ b/test/dm/part=2Ec
>@@ -423,3 +423,49 @@ static int dm_test_part_dos_ext_empty(struct unit_te=
st_state *uts)
> 	return 0;
> }
> DM_TEST(dm_test_part_dos_ext_empty, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_=
CONSOLE);
>+
>+/*
>+ * Partition numbers above 255 take three digits in the UUID made up for=
 a
>+ * DOS partition, from the disk signature and the partition number
>+ */
>+static int dm_test_part_dos_uuid(struct unit_test_state *uts)
>+{
>+	struct disk_partition info;
>+	dos_partition_t pt[4];
>+	struct blk_desc *desc;
>+	int part;
>+
>+	if (!CONFIG_IS_ENABLED(PARTITION_UUIDS))
>+		return -EAGAIN;
>+
>+	ut_asserteq(2, blk_get_device_by_str("mmc", "2", &desc));
>+	ut_asserteq(512, desc->blksz);
>+
>+	/* an extended partition from sector 2 */
>+	memset(pt, '\0', sizeof(pt));
>+	dos_set_entry(&pt[0], DOS_PART_TYPE_EXTENDED, 2, 512);
>+	ut_assertok(dos_write_table(desc, 0, pt));
>+
>+	/*
>+	 * holding logical partitions 5 to 256, each of one sector after its
>+	 * table, with the tables two sectors apart from sector 2 on
>+	 */
>+	for (part =3D 5; part <=3D 256; part++) {
>+		memset(pt, '\0', sizeof(pt));
>+		dos_set_entry(&pt[0], 0x83, 1, 1);
>+		if (part < 256)
>+			dos_set_entry(&pt[1], DOS_PART_TYPE_EXTENDED,
>+				      (part - 4) * 2, 2);
>+		ut_assertok(dos_write_table(desc, 2 + (part - 5) * 2, pt));
>+	}
>+
>+	ut_assertok(part_get_info_by_type(desc, 255, PART_TYPE_DOS, &info));
>+	ut_asserteq(2 + 250 * 2 + 1, info=2Estart);
>+	ut_asserteq_str("00000000-ff", disk_partition_uuid(&info));
>+	ut_assertok(part_get_info_by_type(desc, 256, PART_TYPE_DOS, &info));
>+	ut_asserteq(2 + 251 * 2 + 1, info=2Estart);
>+	ut_asserteq_str("00000000-100", disk_partition_uuid(&info));
>+

Linux include/linux/blkdev=2Eh has:

"MSDOS UUID is 11 characters=2E"
So this change looks wrong=2E

Best regards

Heinrich


>+	return 0;
>+}
>+DM_TEST(dm_test_part_dos_uuid, UTF_SCAN_PDATA | UTF_SCAN_FDT);

