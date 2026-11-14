Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871FE606A327
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 04:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Mt6idath;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P/HAmeZS
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 627EA81B98;
	Sat, 14 Nov 2026 04:05:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bu7rbdGvDDON; Sat, 14 Nov 2026 04:05:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A6B3D81B7B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794629115;
	b=edhCLf/ZbHBAvAZLI+cXKMDfif+S2B9i8sGs2fhYnA8xfcYngIfA3/66uUEF9oIYLf4Z
	 +TmNZdYTnfmlNSo/6Wejy6Ty1UqDmw5uGRUNLbGjlGxaEHy5WKim8u4bPN/i2xWRPBTVq
	 DsDhoaadxV7gT0Q6St/8OJ/c1JyCTDXiu5AeSegikMwiCe9yRulQO1ONz6tIMKjDm1xJz
	 D0KUzJOXY608pWSc7EFFNnBoCyxLEdmt98+haCUpTJfDtXODZRCddWIsMADBp/+ZWtsTz
	 L5lOjbYH69HGQmNnAl2VXRtNKh1HJ19Q3wp1t+msRBBIw1lMJnUjCVL34p/nS+dsrYg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794629115;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=HrRAzx6DplM2wvLLqE0IpTDuWRKlJwR0F/GJ5NKV8Sc=;
	b=R/dBUE66Yp6gRM0T1Hn4OseZKDfP809pm6ywstVmS00/41D+HMIVeZ+pGpQrOcHJjiDx
	 8gCHTmSypldv7VtM+/NzR3iSG7beaq1BpEz9KFRmSzdeuJndzwlQzyZlLhiPb8888VdNF
	 Wc5NVmOIrAP5a0FrsOd2pcaTcVbQ7O/bUIRuljiFSKrDwbQoXkyKce5MBvJuymk5adC27
	 sQATaEMHHb33hTlXrbWA2YQTq9tP84gWrSLOYSHu//qnMJmys7mc2W2/DyFZ1u5tqHe4E
	 HH6AjEcll6VxS+Zd0mp40GqL/67h4pKdCwULHomOEqG2pddE1JaVWRIkymEY5/rsxXA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794629115;
	bh=HrRAzx6DplM2wvLLqE0IpTDuWRKlJwR0F/GJ5NKV8Sc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Mt6idathJllP1GJ9UIoQMOICfyf+p7jhW3W9PZD7hSax9XHEhBGeaJrwjb/1RYa26
	 YhzWb2O25j7u0egpG/lG0q+dEY5xlrfWzBoLzZ5pUKHlmM3/DOGhOyVUXQOTGwmwVw
	 Z2RMCwzmjXUqtLo/HlrTRatn3W6wmNhWUqaQ+77JCp3UkUITalnH3A6UIMjrNOLJKN
	 M9nV71WngFRIZ5YSvA/vywEdu0JJlWF6VozBlgP1/1CHzLxlt+MB/lkZAd+R+7HfgL
	 MQYbY834YyG6TJ0feTwL6yhad+cpyKYbC7ddKILYRgNrqkpx35EvrLz+sTN33Njacu
	 ovOJn7Lk+GHXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A6B3D81B7B;
	Sat, 14 Nov 2026 04:05:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7202D150
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 02:22:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5864F606F1
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 02:22:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TIqcf4bxb8A6 for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 02:22:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 94AF76077C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+me.fromdisposition.org@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=P/HAmeZS
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 94AF76077C
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 02:22:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6FB6B463F4;
 Sat, 14 Nov 2026 02:22:17 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id BFB361F000C8;
 Sat, 14 Nov 2026 02:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794622937;
 bh=HrRAzx6DplM2wvLLqE0IpTDuWRKlJwR0F/GJ5NKV8Sc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=P/HAmeZSKAhiaRkMGSjkRkZPs+9tNYlFGnYdqf8JFLiRx2mrAv2Fc9k6Is8wrPlke
 btdui+DmJfaxx/tPeKGy7hxLja+7rbWBSDppnoVeQSGTYfazuqakk57/VJ8BczZoZB
 Vx02EejRF59u2vYbrh5XVXlyC7bLCMYOFKckPBoprb7cTDf9WVv9QIINc4kBkeorA8
 UIlq+rXuwmf4MF9QXmMy5vaPc40f9jLpM/mQtDuhV3sOKB7+UNmBJomvmDf+tcSVQ2
 TQmKp/DYiB0s6Je4hebJjfzbXxvZOqkC9/Dg86GP1RqIWX+VT8LyBzwpcGsBj9QsfO
 2lJqn65ZR7iUg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 0C7B049C3F;
 Sat, 14 Nov 2026 02:22:15 +0000 (UTC)
From: Demeter Barna via B4 Relay <devnull+me.fromdisposition.org@kernel.org>
Date: Sat, 14 Nov 2026 02:22:02 +0000
Subject: [PATCH 8/9] phy: qcom: Add SM8350 to QMP UFS PHY driver
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261114-sm8350-support-v1-8-414271f59474@fromdisposition.org>
References: <20261114-sm8350-support-v1-0-414271f59474@fromdisposition.org>
In-Reply-To: <20261114-sm8350-support-v1-0-414271f59474@fromdisposition.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Biswapriyo Nath <nathbappai@gmail.com>, 
 Vitalii Skorkin <nikroks@mainlining.org>, 
 Erikas Bitovtas <xerikasxx@gmail.com>, Johan Jonker <jbx6244@gmail.com>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Federico Amedeo Izzo <federico@izzo.pro>, 
 Michael Srba <Michael.Srba@seznam.cz>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Demeter Barna <me@fromdisposition.org>, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794622936; l=1160;
 i=me@fromdisposition.org; s=20261012; h=from:subject:message-id;
 bh=Ab9qigNC7XOApMfoAMRkXiBEl4LYPa9HnS0XaMWBsj0=;
 b=7WHXha0ZKkNvqnex+XZFrnUOhdOGfjDE3kY74P1B73+seBKiwGHKtYmIwRQWEh0vX7DeHAVlN
 w2YzfW0b7h9BHyI4sWBgyt4dKTYrl37cqN9Uw0JvDS9m07Wpp8kihcO
X-Developer-Key: i=me@fromdisposition.org; a=ed25519;
 pk=S0QFlGq1BQEaAtPPdAH8YKEOXMeRuSkTgctXuvtU+1Y=
X-Endpoint-Received: by B4 Relay for me@fromdisposition.org/20261012 with
 auth_id=1163
X-Original-From: Demeter Barna <me@fromdisposition.org>
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 04:05:04 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: me@fromdisposition.org
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Demeter Barna <me@fromdisposition.org>

The SA8775P configuration is made of the SM8350 init tables and is
Linux's sm8350_ufsphy_cfg, so reuse it for SM8350, as QCS8300 does.

Signed-off-by: Demeter Barna <me@fromdisposition.org>
---
 drivers/phy/qcom/phy-qcom-qmp-ufs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/qcom/phy-qcom-qmp-ufs.c b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
index 35fa38a5b3..5a0c406b0d 100644
--- a/drivers/phy/qcom/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
@@ -1747,6 +1747,7 @@ static const struct udevice_id qmp_ufs_ids[] = {
 	{ .compatible = "qcom,sm7150-qmp-ufs-phy", .data = (ulong)&sm7150_ufsphy_cfg },
 	{ .compatible = "qcom,sm8150-qmp-ufs-phy", .data = (ulong)&sm8150_ufsphy_cfg },
 	{ .compatible = "qcom,sm8250-qmp-ufs-phy", .data = (ulong)&sm8250_ufsphy_cfg },
+	{ .compatible = "qcom,sm8350-qmp-ufs-phy", .data = (ulong)&sa8775p_ufsphy_cfg },
 	{ .compatible = "qcom,qcs8300-qmp-ufs-phy", .data = (ulong)&sa8775p_ufsphy_cfg },
 	{ .compatible = "qcom,sm8550-qmp-ufs-phy", .data = (ulong)&sm8550_ufsphy_cfg },
 	{ .compatible = "qcom,sm8650-qmp-ufs-phy", .data = (ulong)&sm8650_ufsphy_cfg },

-- 
2.53.0


