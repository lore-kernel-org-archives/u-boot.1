Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FAF606A321
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 12:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rIKMUiLf;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=btZuW0n2
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F1C4E40A65;
	Wed, 11 Nov 2026 12:12:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WwSTEdr__5cU; Wed, 11 Nov 2026 12:12:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4904240902
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794399163;
	b=AmER/0ytQOVQdANRyCcliETjLw3H+Hum0yxwzfgRvuwst7Q6HSw2ILpRf/mmmW5zMEks
	 g8XygOeR3UnUCv1lJLB2nOsp1wgDdbiOmTcjp8tpRAsv3OL8350JWW2c5/RhiMiJ5g/D0
	 I00sG57p3SBPzHz6sst6UCPsgl6ysjRv4g1y9ORwp8wx4cAa8pMs4EHx1WKTyMxppbozk
	 5QGqPsiaW23/PNb3EuCFRadSqhtk6MYnrdLGm3gQCeYBfPoEbTrvAZX6iRWCOFzULcBk+
	 R64VK7wORAjWfX9eAAnEnI5xBKX3PZkAJBxUNXf4/d1UuX8PWwzDM6VqAn+pgxfmHpQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794399163;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-QQ-mid:Message-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hhL0QnOdxcIQSF+rufntIsnB/Jb+UfluIWAbGsRi8w8=;
	b=IGOfMUw1KB1lXoeRkFmqtsZ7EUxVlQx6aFMWr/s8zRvpXyuB8ZLFkbcm+jNWCiOsRUuU
	 hjrhfYwrZKQTrMtJ6iUr8H1mAqVxGrggiL9q0uSw5QYc8qitD/21ZiDwrXjhfCHJK37MZ
	 rrvix0IVUWF44bhP5mi7h7v5LeNagx9h0MImV32t/DGxTS218PTS1TAz0UAj296b/ERyY
	 IOMse2qswcELP5BsyNnbunByF8q9wq5SW6Bi+zeeHmi9umNNyFZxjDMmuJMd9YN25zUoz
	 y9VxDCxYtFfeoMx5o2nwFGa3+DHMFVKpEIvwgoktYZK8b/US86I7aV0fjE86z82cF0w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=btZuW0n2;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794399163;
	bh=hhL0QnOdxcIQSF+rufntIsnB/Jb+UfluIWAbGsRi8w8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rIKMUiLfe+kUu7YcFHeTLL1B1ywo70L/Rknm+1xkMDF8wjFf+z4f4iMVQJDhrQ5UQ
	 /LTSTUZLVfXO7ZPc2TZX3UC9WmJutg16ElO8NmejUIc8rH8hQ/sBN/2GAtvrVDm6pq
	 aj7t349tSVzC5YMjsl/642+R9dZ/eNKbP/949KrLWwp5iclOk2MhtSCj6TFbCiMeK9
	 i92aDggOZDXus8sJVkgGE3SuiBrHXWi94RYUxDlArqJhVKoM6XneU5N6ojzn/aVtzt
	 eBXFNu4uPK7J44XqCHVIejY5ADvG+sw1D1iQ5GtTvBsmGk9WHD3UM0rHZLqYEO17VM
	 ER6qFbsLE7m7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4904240902;
	Wed, 11 Nov 2026 12:12:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A161A17CB
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:12:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 89D5E40902
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:12:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BnFP9OP-OlhK for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 12:12:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 04885408F2
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=162.62.57.137
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=162.62.57.137;
 helo=out162-62-57-137.mail.qq.com; envelope-from=3305708832@qq.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256
 header.s=s201512 header.b=btZuW0n2
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com
 [162.62.57.137])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 04885408F2
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1794399152; bh=hhL0QnOdxcIQSF+rufntIsnB/Jb+UfluIWAbGsRi8w8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=btZuW0n2H2DWZckGPV37NM7N5egyM3+PN3htyxpD95EiA6iuiRtJfbhyNDNle8M3l
 fjGD/7YJqNzCdggmS5nnx5HTo9OdnOr6gVCSH6a0LEXdScGa6CeuotahSyQB2h2st2
 dByz6yY7kqZb8lQXZsP3Ag8YGm0EXSjLPZfBttvs=
Received: from kongchen-VMware-Virtual-Platform ([39.144.83.107])
 by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
 id 31D9BEF4; Wed, 11 Nov 2026 20:12:29 +0800
X-QQ-mid: xmsmtpt1794399149t3guwfgah
Message-ID: <tencent_798E3DD1842AA6073412B948DEA4A4613209@qq.com>
X-QQ-XMAILINFO: MpYZqmNm/7vMFGVRpMOUOMTfu1l/AOk2WEj1YrSLsC+65gBLjIPktzgGpI+ISY
 8aV3T7hd8l2bJfCUyyH17YZBSlVwSBc39qr2yKNXxWTMUIShk0R4AWlluvUfkfLE/uS277+de7KH
 /X9XfuRXR7Fyb8oSKHwTmTTLkjmTGID+NYJz9icEV4f70uZsnuKMq138IJpofm0CO7ZfOQFBJhpz
 O6QD998cXthjnW8M5yXkIVMra0fMvlZ1LMBQetv2/Jv2Hw8GJXWah2mBX/k1ukFHciUIkVwjEpDS
 gRH8Ypy2cqkgjce71A6vfbng0c5dC71K9QFMWDuQI2S1s1LIaT7FfI/7IcUpSgp+8Xk/2AUP+5+Y
 6SvVR0NCTxrR9VJmp7tw0JToG5hWem5E4L99q+143Z4jcYe07S8WbAS9hwXKEVXhPzG0nC55AtMw
 3TxetmhDUNzgZIvTa1s6cqmJ3TxRIb6IEYmMPQFx1knUg+6a8m0JiXO35P80wgFPdh8LtMhZdeFC
 awt1wg0qy5+OYW//HTg6tctOXN8tJwS5SDzV+Xl1RiYVn6PKz/FXDyoqbhfq/Tx3S4biW0VI0uWK
 XgfNbmiwenkdNSbxk87YFeN1DMomnNEXaoDP896BsZp+dHV0B6QmYkS+BJowFRTveFB8ewFkNYnI
 1Pn/2eC0uYmTxt2vpjjhu408AQN0gpjj0LSSc6ltyhutamC7GwvB5ZyPztm6jwNtGHBDEPl0Agag
 96VXh833dVTB1UQHlcdDwz2mj/8tPXLLKdzWw98bs8CaTuHalvedmk0l58kr8nkZgwQBQMpYAC7I
 dHIsLG2K4MPcY0vHzya2Cr1ept2TM1l20YBLGbfA1Wrp4IbDGvkDSC38SUICHRB9W/PbMzCU1HUp
 y/VrBLENv8WIzFdDtZMQ+I3XpyawVY4vOJOXS7hxsomlIakHrhx8FWXSdxYd6UqIiERWaZ44rPEY
 ZtJljwJGNmlII7t94xJFojVKzeVZRC5UrsM1LAEUSkgDHXr5McX1/AXpa0TxRWTViILQHpud8GKM
 ptc0c5g2Kax57PZvOAutTmjKubrZbdUMAjl/oH1ETWvkOGmt2t+EeAFa0QZmV6B5dMEqvXng==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Yuming Chen <3305708832@qq.com>
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com,
	u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] rockchip: board: Add support for KICKPI K1
Date: Wed, 11 Nov 2026 20:12:29 +0800
X-OQ-MSGID: <20261111121229.12826-1-3305708832@qq.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <670e5c96-6330-4cbb-a8ca-8d2247169faa@0leil.net>
References: <670e5c96-6330-4cbb-a8ca-8d2247169faa@0leil.net>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Quentin,

Thanks for the clarification. Understood -- I will take the Device Tree
to the Linux kernel first and resubmit the U-Boot board support once it
is available in devicetree-rebasing.

Best regards,
Yuming Chen

