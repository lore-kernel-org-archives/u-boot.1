Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5019607022D
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oZYrB9v4;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iLRt5PDn
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BEC71606C7;
	Fri, 13 Nov 2026 16:00:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5z8Oh36Ikzcd; Fri, 13 Nov 2026 16:00:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 008EA60658
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794585608;
	b=YaRc0zD79VEuiZYeVl/wTv4hpw1biZCzVN391bUuv61XuCk/2JKd+rbTTKgp4uJriqJ6
	 17w12yJhmsxskvfZV4AV+Z4/+Aja484B/micpj/EEJij/4rzrETfGu01cywlU0XPTT6Ek
	 s3BFjRMeykeEJwyb3PnitVXDvziwMTlDRgNwQQHrZDfYGyRtM6kJ/tvX6Z0sPNOgfr+fA
	 x1HD4hVY45DbjFxMtLdvBoqkxuXG0DwASKQ/a5pTClrAWVbknLFnZKPt6FhykjuSUItv4
	 HNylgC6BvO4DqrBeCbH7GTqjYZV3LmRfE4xf1hYLqmr0S2WhzUV2zEFklp7Mwfe3gDQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794585608;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VYuVncUeJ6VF/eH95wwhVE35vPaEOp5ygkVDM86ZA98=;
	b=oHay0iO2tJz0KRidljTmPJDaq/AhSOHPrmqLDpjtGn5Dud138kvveGEoFh0d9MptaWGs
	 tnQSzFNKlhF1mdOLrILBDxNZ4tMyk3GPHaXeY438KsN5LcdEdTffUnKk0rCapRmYIAUH+
	 4HCbKtrchqwzpXYGsVSCJ0gO3y5Coh/ApjQhugSeBvZ3i2DdgVPPUTPd10pGSX/6cO9Zq
	 e79RAX0EHfTr4N6Err6dff2+UaDgYxRkuyy2Y+34nxWpYzdxEqXyKlClJBbsFxqiubldA
	 bDa3SHvdSgPir7lZy3m4JIofb4wsCnfRjYoPPD9ghVyy1Sc+N4AwthIp+Tl4mizcTEQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iLRt5PDn;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794585608;
	bh=VYuVncUeJ6VF/eH95wwhVE35vPaEOp5ygkVDM86ZA98=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oZYrB9v4DwBEw0aAU1SuJDXRTooClQIDyKeH1l8uXMC7Wg8yjR95Xx9Zi8miif9yH
	 JRyGyMgX1RONKKoPAmqzPyqTz+PCLNjL3gmvUTzdqM+HTRIfpzzt+k1B/YU+V6Wr3O
	 bIonqmKXDA00qhx5KSF7pJdqg0lTES/uG6g9uUEk4pDL42eiQY57w+3RcRmOKo0cJo
	 aVnrkRbimJVcti6Wwuiiz3VAw4Y8WJJAKW5b8fECt5KVw4qTIzs/5iV27oFg48Z0TW
	 0Y1fIgRVcoVzcTT+aTye4wsJOBrylwgn4+3eS8XeYq1yOT88kKhQOF2GmzbkYzQiJY
	 MxMPLgt5oUQlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 008EA60658;
	Fri, 13 Nov 2026 16:00:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B847228C
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 16:00:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AA12B606C7
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 16:00:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3iyZ6HzoWPDB for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 16:00:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CB5E7606A5
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=iLRt5PDn
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CB5E7606A5
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 16:00:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B3E6762861;
 Fri, 13 Nov 2026 16:00:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200AE1F000C6;
 Fri, 13 Nov 2026 16:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794585603;
 bh=VYuVncUeJ6VF/eH95wwhVE35vPaEOp5ygkVDM86ZA98=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=iLRt5PDnQaQl6jmKfCG+VvhEh8PPqJRmIQJ8qhvuXUEHOgCPBblq1biartvZQ3Qub
 rm7h/d/HPxw4dxNcmPBS88prqzPwA4Zjn0xq0Xjr7sRZPVTBy6vWMAOPcAUutyGB2a
 UZhZD1BwZiSBrmEHKtwy8DflvbcJfB65ZdISKtu+oJCXnCo2tr/JKmtv5PTPww+On3
 +YTWTuyJAa4db0Pw+AzlEijrMeOcZCNLq0Th68RAFwGKlLL7V4tlScT0UXsPhLg1XN
 SSB4PF2BMCy3GDGtoHDYT1gI3xeuvoKIspenLsFW2/ONsENkDJQusDi9Bw271uBrkT
 JoIKjer/slVBQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Simon Glass <sjg@chromium.org>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
In-Reply-To: <20261029-upstream-android_init_boot_b4-v1-1-30c95feee363@oss.qualcomm.com>
References: <20261029-upstream-android_init_boot_b4-v1-1-30c95feee363@oss.qualcomm.com>
Subject: Re: [PATCH] bootstd: android: load and verify init_boot
Message-Id: <179458559575.70612.11839034891089065276.b4-ty@b4>
Date: Fri, 13 Nov 2026 16:59:55 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=396;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=o3F0Mmkp0mkW8hqiulxcryRiYzg9VCqgcqx9duLHTvk=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq9zQB7Uya5YGe8CuYi7Ims2VhDqKHOdKrLv7mm
 rcSHr8/6IKJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCavc0AQAKCRAZDR20Zk4Z
 NTsWB/4z18ZhyYsIG6mftRAXaJox0KeqweNRBxkvGEV13SAWpmWpsKi7IW1Yf9bHp65g18EgmH1
 q055dSwoVDhz7fMXB5u6qEoIzc8coq4JmQSt/zhuZ5GWuWBVfTfSEQPwvuRkSk0A+jBIpnTTf3V
 wAPCkLKE4ZlkUeF727Xjx33eDYixPEqoktADBE4HFkokX8KIGSMtQkNqCOjz9F8DGeghPyirQTG
 8F+plAobCb5dbcv14S0ZkXA3TuR/KjtjAz2w5tKWwIHAvKwbmA53kr5n4zvLkIgZi3UiqMJDEsQ
 czV+7ubOzTDP6Hhr10mLSbikgRoK5yuNWnpZ13GMWdWAeTRW
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Thu, 29 Oct 2026 10:20:19 +0100, Igor Opaniuk wrote:
> bootstd: android: load and verify init_boot

Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/1] bootstd: android: load and verify init_boot
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/5b15e8ad1484dc15792c859766ce3048ec4bfd76

--
Mattijs
