Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1F4606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 10:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NIW+RfB6;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=CjyxCK6s
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49B246066D;
	Wed, 28 Oct 2026 10:03:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hcL71ejp2vbk; Wed, 28 Oct 2026 10:03:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 43ED3605F1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793181797;
	b=eYoQjDELVTqNrWCjn2Z1FpAM+i5Hk6fd87daFxf8zLXqzT6NsBSrMXm3sF/HhrXXqsnq
	 wqAjNk2I8FSRCBYrV89MP6FbvweK5xx7/nv5DiVXhf72lhhYmd6udF7BR23WXMBd09XNu
	 amFzkBehsQMAGbJZKpvgwHqRyJ2VNJqN/GvBIw7/te8EdTe9lk2n0A2fZ2rtBtj6e933X
	 2WD9bOzrAy6YRk6yKtNkbEJJ+F1sUP32nd0q9HMkvHRvDp6/EnNkezn+H5Tv/41Em4Osl
	 gzVNfEYe6JhofNap5py6Qt7lilpg+yoCO5LjkfAghoxNKZHzPg5yVaHsMTNF5tAJppw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793181797;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=szwZ2w0oldmpk8vTGCuA1R+Nsj1MMxfz/1Obe4/4kP4=;
	b=Rp5hupI3DXj3SvL/ZMYdN4IWl1rmrbWqVmA4vsymUG9xsha0egz1T941l7KBM5u1oyGp
	 sgF7eLQ6ujBXtlYQbyun7Etzswo05WpJy5VLqRYp8kYvXQ49kP6pA/0Wv0pZ8xtBZglUw
	 chspkfftzKUpqVN1Us/Sntk5N7pfEMGL9B8OCqZ+cPDyetCiMW/S62dkMN5V69VlozI9W
	 z965Dygpc4n2SRO7qR8gpoMl0DOARyXm9W1iExbSyD5wu9g6Un3zQtQHWZVwSP0wfW1HC
	 Px4aTujoq1eoLaUmgk+vO67RFrcamJAFR2Nf33cvcwHo4Wn7cuIxKuwcqQ0yAvF0fuQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793181797;
	bh=szwZ2w0oldmpk8vTGCuA1R+Nsj1MMxfz/1Obe4/4kP4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NIW+RfB6qU6gwGBwGwrFVGF9rjcep7qDAxYamLukJ3WjrNz/frWfcnUe9nL9jiFdT
	 o/7zGZb+/BQYAOFAEN65c3lgoTpAUXMNc261DRT2Ci8BHRwLWWskWqRftW4CTrp8+B
	 G3relVf/hpykU3NpvrR0LnFFm+G6jwgWYLlTYQbGCkClEC7rxXJ5EVR94tR2vaeeK+
	 zgN8m2FKeuurwWmVLciwZ8gMDIZ7yxqVPLjVTnwTq+HTHpjWLWcoacumnDfldeelCU
	 majbtS28HtHUj32TRaHFCYdvaZ+jm+RO6lqCLkhMBpczzFQVys+wSBAmPPOPkrohPo
	 HZ+HaaKNfbNdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 43ED3605F1;
	Wed, 28 Oct 2026 10:03:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 93E9A235
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:03:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 857EF80CEC
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:03:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0cauO21dkKcv for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 10:03:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D29648085B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=67.231.156.173
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793181794;
 b=YxLp0pzAQsnu837iacaj4hK64pwsbZx8E2h4bW2JMSidWCduKf25REBAOyxbay69Qcn1
 qObNZh/7qp9af7eLBrg/lrJXY+/wR0R2iQ9YPfE09ozAWuTe8e1+g15R+jOerVNCS2H4L
 Bcnq7p27PUDIfUgPaVYikROAgkVEl5L+vtQCEZfhsxlLtEHNBSdUXxBS6SeNKbfAuDjcx
 nFec95RCFZWbmu9n4GKAd29a37lUPnbx16F41r1sHBt4LgnkKMSlItJjwKBA6A+/mrmUV
 ym2mNMgbhQCLtDkE2lHw88+uBpdwKU0A7lOBXK6WX2nMXFsXrz5klS4GZH/Dnvo++7g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793181794;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:Received:
 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version;
 bh=szwZ2w0oldmpk8vTGCuA1R+Nsj1MMxfz/1Obe4/4kP4=;
 b=HcwFojkwPDy/6TWmCfTFKu1uCefJpKQURxbp1W8JxZLC5pMCeg/pGhK3WZbmW7Rt7yBW
 t2K8hfTdTvqXld+1pBh24uhoIrrhziRWsLFl7NrSSXnfNTNUdlICQgUwv57IUNgHPHKoB
 V3CqZK0LBE/UO/77m2tlkwtXzbM+Fz9GB62Pgq0SbLpDQorSmT2szAV70eA3LQC+BJmqa
 68Dp482q1+8PMdwdDJrRbnqjx9vzP8ZaUGWLTw1otQ46BHBcMRl1GVtCSwhNa4ZAY2GWf
 G853meKucdcG50qzfuRVANTnzekYzXCIfLGPIVryrUhQTjfp+8HhB3pUWzGnldI+osw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=marvell.com;
 dkim=pass header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256
 header.s=pfpt0220 header.b=CjyxCK6s; 
 arc=none smtp.remote-ip=67.231.156.173
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=67.231.156.173;
 helo=mx0b-0016f401.pphosted.com;
 envelope-from=prvs=2761532eb6=akashn@marvell.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=marvell.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256
 header.s=pfpt0220 header.b=CjyxCK6s
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D29648085B
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:03:13 +0000 (UTC)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SA2brT243944; Wed, 28 Oct 2026 03:03:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=s
 zwZ2w0oldmpk8vTGCuA1R+Nsj1MMxfz/1Obe4/4kP4=; b=CjyxCK6sgfOprqn2k
 C4OqVBS1DUROn5JJSm73anrXBuly+PJCANHxVO1FswPisAEBFsHKcX8oyxx4npNp
 M3szfwGCIP0zKzqOhLfDH+zD0Vmmb5Dyh8j3p3RULZgpdZHHxIfw6F3JTmnLM9IJ
 xIRLvQqo59abppXL0rS44ZfBaVeDvBPZI3uv+KlH0svbhnaZH6TbTYJOshuFTSTn
 awC483gdQ8kY2ewoRcv/PexD0P4AtUKf25MvXpyi7UE0VtCXpNuPz9HM6KYnYrsF
 N8UGMwYL9BRBsyosz1iZzfA1gBlxfAOMhL7zHRo3HK4abNa35OyBu9s1XLSusAEy
 eHURQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hk1a3uh24-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Oct 2026 03:03:09 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 Oct 2026 03:03:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 28 Oct 2026 03:03:07 -0700
Received: from hyd1-dt91330.caveonetworks.com (unknown [10.29.36.146])
 by maili.marvell.com (Postfix) with ESMTP id 0AB3F3F70D0;
 Wed, 28 Oct 2026 03:03:05 -0700 (PDT)
From: Akash Nair <akashn@marvell.com>
To: <u-boot@lists.u-boot-project.org>
CC: <trini@konsulko.com>, <jerome.forissier@arm.com>, <akashn@marvell.com>,
 <rkannoth@marvell.com>, <naveenm@marvell.com>
Subject: [PATCH RFC 1/2] net: pcs: Add generic PCS interface
Date: Wed, 28 Oct 2026 10:02:57 +0000
Message-ID: <20261028100259.2491887-2-akashn@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028100259.2491887-1-akashn@marvell.com>
References: <20261028100259.2491887-1-akashn@marvell.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=cLh1IVeN c=1 sm=1 tr=0 ts=6ae1c85d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=VkS46JiJSd43FcMYU_IA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: EuPegvolViE_OUuJIb5QxvpOKNUMSfCr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAzOSBTYWx0ZWRfXw2+Ys6SDTDMz
 bJ0sxjtABTgwumQlL7kYGMsWdfXS/P3FKIEvGMW8qbAcTJ1ii23GMVjhjtKgFWr82iTU+krVuuy
 slLngV6Gft9wLqvmtZd4xflRCKf30b0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAzOSBTYWx0ZWRfX7oXsKYDo2Uyn
 LiEegki/Tai68Ik3I3MMkV5KRQ6MeHzkxNqSWtKOEFNFEwmW7KF0mg7fFqPp/PhxoJDBkisQ6uz
 AanjTyLBbY+KDLXbk/+0vO8OHDNPZqXMicMOqqv5W6+0mcAD+wYP6sYeqFGobGtv8wabQGP52Zu
 Bzeo9iNucR0l8EgQSboal2FIUBEREelfI3GuigBQxAqgto6Goa059pGtzjL4RjV4ZBzGA4Dm83X
 T1dhkdll/HGYYHtKKJSrMB74d5YofUlRFqar0ffvDz9hYVTGmph6Jb0fY3zffsQIuuIXpot98CF
 1fY8ppiNKrXoDHPK/xjqwdMVjqFwoKAVEMldjrWrD1D0C3/TzCdiy/9dnZWcQ1iKHaJP89Xp1H+
 f2ZJmPgAe6zrAfE9rOdJ515QfHqwhEq44UqmZJJwHb6fDhBfyN10C3RHtFn3iYgpJw3VgYILMcS
 3F2bq7A/olK8EJG+G3Q==
X-Proofpoint-ORIG-GUID: EuPegvolViE_OUuJIb5QxvpOKNUMSfCr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_03,2026-10-21_02,2025-10-01_01
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add include/pcs.h, a interface for Ethernet PCS (Physical Coding
Sublayer) devices. A PCS driver provides a struct pcs_ops, and a MAC
driver calls it through the pcs_set_config(), pcs_get_state() and
pcs_disable() wrappers:

- set_config selects the interface mode, the auto-negotiation type
  (none, Clause 37 or Clause 73) and the expected speed
- get_state reports link, auto-negotiation status and speed
- disable stops auto-negotiation and powers the PCS down

A PCS is a UCLASS_MISC device.
The MAC driver is expected to find it by phandle.

Signed-off-by: Akash Nair <akashn@marvell.com>
---
 include/pcs.h | 140 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)
 create mode 100644 include/pcs.h

diff --git a/include/pcs.h b/include/pcs.h
new file mode 100644
index 00000000000..710b8136d04
--- /dev/null
+++ b/include/pcs.h
@@ -0,0 +1,140 @@
+/*
+ * Generic interface of an Ethernet PCS (Physical Coding Sublayer) device
+ */
+
+#ifndef __PCS_H
+#define __PCS_H
+
+#include <dm/device.h>
+#include <phy_interface.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+
+/**
+ * enum pcs_an_mode - auto-negotiation used by a PCS
+ * @PCS_AN_FORCED: no auto-negotiation, the mode and speed are fixed
+ * @PCS_AN_C73: Clause 73 auto-negotiation (backplane, for example 10GBASE-KR)
+ * @PCS_AN_C37: Clause 37 auto-negotiation (1000BASE-X)
+ */
+enum pcs_an_mode {
+	PCS_AN_FORCED = 0,
+	PCS_AN_C73,
+	PCS_AN_C37,
+};
+
+/**
+ * struct pcs_config - requested configuration of a PCS
+ * @iface: interface mode to run. This selects the PCS mode.
+ * @an_mode: auto-negotiation to use with @iface. It must be one the PCS
+ *	supports for that interface, otherwise the config is rejected.
+ * @speed_mbps: speed the caller expects for @iface, in Mbit/s.
+ *	0 means not specified, which is accepted only when @an_mode has
+ *	auto-negotiation, and a mismatch is rejected. A mode without
+ *	auto-negotiation needs the speed given.
+ */
+struct pcs_config {
+	phy_interface_t		iface;
+	enum pcs_an_mode	an_mode;
+	int			speed_mbps;
+};
+
+/**
+ * struct pcs_state - state reported by a PCS
+ * @link: the link is up
+ * @an_complete: auto-negotiation has completed. Always false when the mode
+ *	has no auto-negotiation. It does not mean the link is up, so check
+ *	@link as well.
+ * @speed_mbps: speed of the configured mode, 0 if the PCS is not configured
+ *	or is powered down. It is set as soon as the PCS is configured, not
+ *	when the link comes up, so a non-zero value does not mean the link
+ *	is up.
+ *
+ * If the PCS is powered down or not configured all fields stay 0.
+ * If pcs_get_state() returns an error, @link and @an_complete
+ * are not valid and should not be used.
+ */
+struct pcs_state {
+	bool	link;
+	bool	an_complete;
+	int	speed_mbps;
+};
+
+/**
+ * struct pcs_ops - operations provided by a PCS driver
+ *
+ * @set_config: Configure the PCS for the requested interface mode and
+ *	auto-negotiation type, and start auto-negotiation if the mode uses it.
+ *	Returns 0 on success or a negative error. On error the PCS is left
+ *	unconfigured. It can be called again later, including after @disable.
+ * @get_state: Read the link status, auto-negotiation status and speed.
+ *	A negative return value means auto-negotiation failed.
+ * @disable: Stop auto-negotiation and power the PCS down. Calling it again
+ *	has no effect.
+ */
+struct pcs_ops {
+	int (*set_config)(struct udevice *dev, const struct pcs_config *cfg);
+	int (*get_state)(struct udevice *dev, struct pcs_state *state);
+	int (*disable)(struct udevice *dev);
+};
+
+#define pcs_get_ops(dev)	((struct pcs_ops *)(dev)->driver->ops)
+
+/**
+ * pcs_set_config() - configure a PCS via its driver's set_config op
+ * @dev: PCS device
+ * @cfg: requested interface mode, auto-negotiation type and speed
+ *
+ * Return: 0 on success, -ENOSYS if the driver has no set_config op,
+ * or a negative error from the driver.
+ */
+static inline int pcs_set_config(struct udevice *dev,
+				 const struct pcs_config *cfg)
+{
+	const struct pcs_ops *ops = pcs_get_ops(dev);
+
+	if (!ops || !ops->set_config)
+		return -ENOSYS;
+
+	return ops->set_config(dev, cfg);
+}
+
+/**
+ * pcs_get_state() - read the link and auto-negotiation state of a PCS
+ * @dev: PCS device
+ * @state: filled in by the driver, zeroed first
+ *
+ * Return: 0 on success, -ENOSYS if the driver has no get_state op, or a
+ * negative error from the driver. @state is not valid on error.
+ */
+static inline int pcs_get_state(struct udevice *dev, struct pcs_state *state)
+{
+	const struct pcs_ops *ops = pcs_get_ops(dev);
+
+	state->link = false;
+	state->an_complete = false;
+	state->speed_mbps = 0;
+
+	if (!ops || !ops->get_state)
+		return -ENOSYS;
+
+	return ops->get_state(dev, state);
+}
+
+/**
+ * pcs_disable() - stop auto-negotiation and power a PCS down
+ * @dev: PCS device
+ *
+ * Return: 0 on success (also if already disabled), -ENOSYS if the driver has
+ * no disable op, or a negative error from the driver.
+ */
+static inline int pcs_disable(struct udevice *dev)
+{
+	const struct pcs_ops *ops = pcs_get_ops(dev);
+
+	if (!ops || !ops->disable)
+		return -ENOSYS;
+
+	return ops->disable(dev);
+}
+
+#endif /* __PCS_H */
-- 
2.43.0

