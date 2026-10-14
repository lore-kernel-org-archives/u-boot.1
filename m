Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9000CC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 16:19:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F91340790;
	Wed, 14 Oct 2026 16:19:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R-aYgqwLIrqb; Wed, 14 Oct 2026 16:19:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E0AAF40787
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791994799;
	b=YG7cWJlXgBRpK0ZjOGw3TrApXGvEmHeYx6+TFLokkjM8QvLoRYC6yGXu0U+R4Py1HG8e
	 gJC4wQCIpiMAulMflOk0Y5VvpGjZoNZd6PvKqVeGcTjstzDUd8xzvrq+kz1s9gdCTl/aB
	 Kg7/C7OBlN8SjPsf3VNPkkRaWnwOKHtK/oJdQMQnd7ymGVlra+TgnVLyGpXRFSLnH+mng
	 Pl9W6XcXxBeyZDoNJaF9G8BU6gIgOlHzYmCki1V3ZPL1V+gDrzTyfy4XwRhC3bU90W0Tu
	 ExZqBBpJia9DaTGS5ZP3BZUwEJ3rCo9GTgj2zJspv1VaeUNB3cYhRdiyGASxal3/xcA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791994799;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Pre-Result:
	 X-Rspamd-Action:X-Spamd-Bar:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eL9InljLedUdP2Aj27OcZnAn6oWbDm4fmsVs0lnIkjo=;
	b=C9gYjojC+OGKRqbD3IEPj0kqVpwPtdwGWcxAhx9yU6n/F9mv8tgI1wnmfVBL8U1ME2Ms
	 Telk3qiTbAohQnpiPl/LHoX3rMKa3L3SwaqL84E3iQAs0mHfnjbplv+LpJoyN+CgVzWhE
	 Nnj298MdlYvkXAjOAe0TX3PhadIIpGyNoHayCDFRANNHPMFNDP4PAcYoyQKOBpfG5Iwr4
	 beGDDglQCkJiqgW5GYyFMQGWhLZkeb7SEK36x9PgrSDUuFVTyl026+d1KWoQWnWpJcwNb
	 mvINUg9AtBeVkHl9KsoL0qyYEaDOvJuc6XC0eOrbgw0DTPl/gRchNkSRiSxgIH5INWg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791994799;
	bh=eL9InljLedUdP2Aj27OcZnAn6oWbDm4fmsVs0lnIkjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fv2Snpr7a9ohB5lnGdnvCKWLtiwp6VQ4WIME3SNuq/i8R7QWFZnIOayhfsFFjTNsJ
	 Uwn0XO9XGLx8s3RFrM74D/Gp5KCvNcRsX+YILRfm5PBFvJ5aWVZD8E2siNG0qUH+oJ
	 j94cVv42Ct12nnGz9duMV1R5kqs+aJ1rrZA5SXZ+l7K0UpAopctkCsKY1r3DZ+vJKP
	 gM6D20fU4u81J2GM7UtDWJbnXLEIKUTmS9FLFGIc6EXUP0QXZGp/BYDARPk2H2u4y4
	 fy1xx17uCEU6sVHjOCv/YJ5nWjZlFwzRzVVkA1046ixS1LI5RorDdzDbyAOH9SfMjq
	 FtPfjxXiIzRIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E0AAF40787;
	Wed, 14 Oct 2026 16:19:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E3968769
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:19:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C9A3E80EAB
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:19:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V3_9DLCQP8Bg for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 16:19:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E8F9980EA8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:1488:800:400::400"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791994795;
 b=d7i1O9Uk1wYbW6xd9zv7Xk8c2Fm09Ln/GB6lR8CDW+weL3qMTSHD9XsNiro3bHA1wLj+
 oVICM5G2H7mLqyQR5ZrsYtELxdhE5j7MQkugmO4PWllAxj0OzqK0uq/mHkoU5otd9nWOb
 bjzLaocRqOmeEYoZigj+UA29NnPlj/FsWptpRm53LmjlQxJOZNMTL2T+I/Otph2Gtcao3
 6luRfZDwA6LUF24a/FptZAFLM1UGCgIU98S0//DTeZ5O4u+vrLWAhi4fx9Btim6WtCPly
 mi0iV8gQL9GNtYl0TP/dXYqphMS0gv9sKCrQ0NzsUmzO7teqq1CNe2vFQQznqmVToNg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791994795;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
 Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Pre-Result:
 X-Spam-Status:X-Rspamd-Action:X-Spamd-Bar:X-Rspamd-Server:
 X-Rspamd-Queue-Id;
 bh=eL9InljLedUdP2Aj27OcZnAn6oWbDm4fmsVs0lnIkjo=;
 b=jCKXMJ6thtXH8lFfalMd4RaA8fC8Dtw++0GovoGhhl94tb2nRZtsLqSs3XJ6k737W/87
 0/mwo5DDt6r+v9VEmh68jtS4OgJ3QjzmAdvWAafNAxsTdsOCEORbxFdCnpi9sVXLCyU93
 HhsxP3WB+c7/vQeHJYAahEwi9l9298Z/fJ1dgpXcMJLD9cufWqwvxFqQezTIzxF1Pl6mN
 pJsZljfsQd2f937CgWxbnWOuZWuS3Ax4I5FKmvEiMerdPchYU3HJJlYMcJXIBi5yYTgOL
 gbgG85Rb4uBwi6YW7wQBYP+624DpGVS0suwKOui7KGu5rFsFgL8ev5rrRGmBIUUQTvw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=nic.cz;
 dkim=pass header.d=nic.cz header.i=@nic.cz header.a=rsa-sha256
 header.s=default header.b=VWdNdS03; 
 arc=none smtp.remote-ip="2001:1488:800:400::400"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1488:800:400::400; helo=mail.nic.cz;
 envelope-from=marek.mojik@nic.cz; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.a=rsa-sha256
 header.s=default header.b=VWdNdS03
Received: from mail.nic.cz (mail.nic.cz [IPv6:2001:1488:800:400::400])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E8F9980EA8
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:19:54 +0000 (UTC)
Received: from marcharch.office.nic.cz (unknown
 [IPv6:2001:1488:fffe:8:8f8a:daa8:a10e:7064])
 by mail.nic.cz (Postfix) with ESMTPSA id 8FA9E1C0607;
 Wed, 14 Oct 2026 18:19:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nic.cz; s=default;
 t=1791994792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eL9InljLedUdP2Aj27OcZnAn6oWbDm4fmsVs0lnIkjo=;
 b=VWdNdS030QoW3xy3z35hWZIDSk5T7AqZesGNXoqU1IYKlFAxcuLsyMpwHyV2jKd6hmQqy7
 A2WXDiQLthP3CU+zFzOGdjEjkxpjifA5Ah8PyEQls4/p7MBb8y40/Rdjyg1vMZ1ZIgKCeh
 XJ1iQnvuWZk8Di6LwPJ+598O0FnZu5I=
Authentication-Results: mail.nic.cz;
 auth=pass smtp.auth=marek.mojik@nic.cz smtp.mailfrom=marek.mojik@nic.cz
From: =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>
To: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Marek =?utf-8?q?Beh=C3=BAn?= <kabel@kernel.org>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Christophe Leroy <chleroy@kernel.org>, Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: Re: [PATCH next 11/13] board: CZ.NIC: turris_1x: Make NVMe and SCSI
 boot targets conditional
Date: Wed, 14 Oct 2026 18:18:21 +0200
Message-ID: <20261014161829.28404-5-marek.mojik@nic.cz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260928110434.70686-12-pepe.schlehofer@gmail.com>
References: <20260928110434.70686-1-pepe.schlehofer@gmail.com>
 <20260928110434.70686-12-pepe.schlehofer@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.10 / 100.00]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_TO(0.00)[gmail.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; ARC_NA(0.00)[];
 ASN(0.00)[asn:25192, ipnet:2001:1488::/32, country:CZ];
 WHITELISTED_IP(0.00)[2001:1488:fffe:8:8f8a:daa8:a10e:7064];
 ALIAS_RESOLVED(0.00)[]; LOCAL_OUTBOUND(0.00)[];
 DKIM_SIGNED(0.00)[nic.cz:s=default]; FROM_HAS_DN(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+]
X-Rspamd-Pre-Result: action=no action; module=multimap;
 Matched map: WHITELISTED_IP
X-Rspamd-Action: no action
X-Spamd-Bar: /
X-Rspamd-Server: mail
X-Rspamd-Queue-Id: 8FA9E1C0607
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

On Mon, Sep 28, 2026 at 01:04:32PM +0200, Josef Schlehofer wrote:

> A Turris 1.x configuration without CONFIG_NVME or CONFIG_SCSI does not
> build. The NVMe and SCSI distroboot targets are listed unconditionally,
> and config_distro_bootcmd.h turns a target whose support is disabled
> into a build error such as:
> 
>   error: expected '}' before
>   'BOOT_TARGET_DEVICES_references_NVME_without_CONFIG_NVME'
> 
> List the NVMe target only when CONFIG_NVME is enabled and the SCSI
> target only when CONFIG_SCSI is enabled, so that the NOR build can drop
> NVMe and SCSI to make room for the ubi command. Both defconfigs enable
> NVMe and SCSI, so nothing changes yet.
> 
> Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
> Cc: Marek Mojík <marek.mojik@nic.cz>

Reviewed-by: Marek Mojík <marek.mojik@nic.cz>
