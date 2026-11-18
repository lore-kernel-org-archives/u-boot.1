Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D4C606A334
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 15:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=c0/SY95Y;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OkQ6bymU
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B84481134;
	Wed, 18 Nov 2026 15:43:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KapvavkOGKKa; Wed, 18 Nov 2026 15:43:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A6BA280CD4
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795016635;
	b=qEz6FfvZtY5F8iBew/x5yo/SrRXT/lo1HavIVvIF9O2mh8hHmq4ZN7pwXQSKyWrkro1r
	 lwYH6VuVVyzPB7dRpCH/6Bv5rxJ2Hzl4yoD66dMwEwPo9AgCjm2QuT5xNkb2D8iCT2E4k
	 CbAoSUQHqrnY+EL9r1OBqnL66Ydq+hG1RgA9T7NBXjXpHAbKYw5vPcVjLBnOJM8L4cIby
	 YHORcdwHBqkq+OT2RzRUFqClUkMa+qsG7MI3TqjcSN43vaozzCVC8Kbk1vWqysp3qpjRR
	 gRAgkBWJKyseeloLMNuMwisqWL+9+yy1ceOREbkjoUQMiwnFC3Kc0/1KYJWB+qz5wAg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795016635;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=50of5hBumIq9CrGeBbA3CJ2Yab0Cng+sYV+jsWanrPk=;
	b=a3rztiv8c+5eS+zyFRkM10w+M3wejMNGWmUwpLe7s9ehiFf5+7SLoVtWSHfc21lFJuTk
	 gjQgV36+qUB2CYKfwf1oldNOA0huvEPOX6kVlwHrWw7SHX37jW7knMWbzyDNRuHD1nLZM
	 40JqNe2OL48ttyAoWMC1/q6+mAredSkAHLGtXZZvx50ykt2IqOxN+1sJX8OD/6UOSgie5
	 JjgntVh2ArQV6TBjIDAsJItI6nqDBrQj6n8wjchhzgU8XDwYDRu15M0V9mUhVSjwmNws4
	 EiYPJMrBFjTOLPRdqSz/rXP+9EwIbL4xvp55/R3T1JcEDAOk6cbnPh2cZj9ll4A0wQA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795016635;
	bh=50of5hBumIq9CrGeBbA3CJ2Yab0Cng+sYV+jsWanrPk=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c0/SY95YisHCUkHx7v0PUppTRueylDkrMe9s+3gEWmAd7A1UGJMXnx/BMyuMjvnK0
	 gFv+7VlCv10Qn8yc/V10EUeufje1wRuLK6sV9w5YAW7FpBzdc4Rf+Cq2ikqjjuIFdw
	 nbJ43/81KIuLzhaxoOXDdUhNZDJpfX/Nf0jlUXhz1domT9X2pJCNQbd2Rms7IfDFCZ
	 5EEMDzO3LGRsfOBypnn+IAx7rLGxxv38xFipZ/4tqSv17dtRPFArB3pxfTZzplSaVL
	 4WITdarx38ja4xsJEK0z6D6yl6A3H2VYnAseRG9njPGhczjRAoNCmx5C2J1CnxZMmU
	 PON+ILX7CsO8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A6BA280CD4;
	Wed, 18 Nov 2026 15:43:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 80B48977
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:43:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6041660A9A
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:43:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1W8n96hF_8CT for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 15:43:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 42BA760A8E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=OkQ6bymU
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 42BA760A8E
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:43:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C84F06240F;
 Wed, 18 Nov 2026 15:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1001F000C5;
 Wed, 18 Nov 2026 15:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795016627;
 bh=50of5hBumIq9CrGeBbA3CJ2Yab0Cng+sYV+jsWanrPk=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=OkQ6bymU49Lex1IIgu0T17PL/HJkbzCDEXfQwBOFb7bBhFtd063MfIJwR9orTrpFT
 S03msIxO2yJSOY/7KHWiQD90utwnBdI3IaEBA5o/7roSTIiEwMKPJt+4+HpzvlXH4b
 NEfCSwHpvnIE7JZjeX06c/WEqqCLRTM769QP+0VsT8rAPYSIDiTTrEqymBfDId75Cg
 sKybAIwAlqsT9MWRfePPw8z3WsF/sou8pwXD3FiCXlPihhSVwzJEEanH5qM5BDoJ/x
 FluUxZd4l6SGpKlmybt8UCPtuSlvZXS62L0XmDrvTe+Svpd/AO+cm2gFAw/ypu4kGV
 JvSPw+RefuF+w==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5/5] test: dm: fastboot: test the flashing commands
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>, 
 Jens Wiklander <jenswi@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20261107-upstream-avb_tests_b4-v1-5-9177277458f9@oss.qualcomm.com>
References: <20261107-upstream-avb_tests_b4-v1-0-9177277458f9@oss.qualcomm.com>
 <20261107-upstream-avb_tests_b4-v1-5-9177277458f9@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 16:43:33 +0100
Message-Id: <179501661323.306911.8668200612695831210.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=483;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=9hgOx8SOVyJXnqzyizm3gBgheYqWPyiOKaVhWbF/QgQ=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq/cenjcK+x6OC5VHuBh+pOALBpJeORNi7CiGa/
 e99wZUzjLiJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCav3HpwAKCRAZDR20Zk4Z
 NU4BCADHeW1hUULUFomyHsvWV1AyCFHaYHd6SieTvJG88KmR2jkuOL567dActWuSAgK/wYk4FC5
 NWgleAf4At0I7HObzLIh89elecBhBdK00/rdXGNl1XsmCMKThtyJMdtkr/ZLOSfhfaWFWaDybbf
 TJoLOalrlPqKbYJKpLcwvVOza7SXbbaDLowGrSUhZtFCdEMfWsIe5/5hrmHvVTkFJ/tAu1Wk2oZ
 2C7Oh8YdlSAv98tGgbgxS9ic7MTlPpxe+xDzuaOjE0kz3IKivPQsBvDQcEY1MadrcEfY8V++9MQ
 DQ1cwzn4etB5eutAGm+M3pEWt7LPJWTq/Gd3SHXJIP2CH9tD
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 07 Nov 2026 13:52:53 +0100, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:
> A locked device must refuse images nobody verified, unlocking needs the
> user's consent given in Android, and every change of the lock state
> must wipe the user's data. Enable FASTBOOT_CMD_FLASHING on sandbox and
> test these rules through the fastboot command handler.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
