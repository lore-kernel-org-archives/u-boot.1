Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C632C88E50
	for <u-boot@archiver.kernel.org>; Sat, 12 Sep 2026 01:07:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 35E6660660;
	Sat, 12 Sep 2026 01:07:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VSO8K3IsFvKH; Sat, 12 Sep 2026 01:07:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 82F28606DC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789175254;
	b=gRZzuHxupVuHE1uuR5RJiq0GJbXatuP3+scJfvq5HfIndIADfn4RfFAWDFaWd+poTCnx
	 98MCMueaZeVFJvqU3fjSS5Is3u31aiVi2hA0g6mdZFIN+G2qOEhV6QAV0YoMR6PsRkJSQ
	 IT4vD2Uyc/SNJPCYYacsuX3i5kH3XHHEoL8zSyOupocN+IjOies9KEO/CjArhwrkQnWEv
	 BZrit2GKCo0NHNAYpedOerr/bnk+W4o4+IUe+S4nqOtwvttUSmK0sPVDolZ6gHYqO5CZQ
	 TBGIcujdF3aGoi67ZtDYXnvUBwSLfB1Pg108DKJfWV4YbxscmapF8bzcUBVG6Ki08Xw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789175254;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=dUCrouaQS2dyNydaS9lFgUSuIUdM/7DT0GmGyVMeNo8=;
	b=FnsDdrOGTyof0PURkKZSd7CL0dbc9jniv6eCXraMWEaPgQBjyeQJj90RxxmrmjWtJzSw
	 OUtPZG2jmSJeopGMRwsKHddFg61d8SvmIDt8JndafmVDCFS9SWh39g1tDl/w6/MA0IAXd
	 Hoe7NtAZxlTpxgg7HfIM14V3k6tx5IFei4XTM/FJhiU3aRqEhrSMm9lN4zY3SKumO2KNt
	 b89M7Z3HQUVMMzsPH1P65ORZKM6yswZ/I/4Sr9ANW8RexPjj5ck821iOWruBBeatzLO/x
	 3n0gk+GBrIqAIFMNusenPA7crwB5qyH7UYTDRMjQ8hRqXiil9bDIsMRpXJta6qQ4u4Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789175254;
	bh=dUCrouaQS2dyNydaS9lFgUSuIUdM/7DT0GmGyVMeNo8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=SioOpNNsNGeLJwKL3tZIAAIFuZGFloFpGY+0DedP5yvvhRluNxHFf1vL0zUwmG35r
	 MhjmanYmSXoZGUq0+5PHL9c5UQzgbMOTwRWBfjEK1q1ccKtjL2ACEKd6a49Z3G4t6U
	 wTjxu2XsRs5lwTyRDNRVOHKJ/WzXbg/XR2l/xNG21Lt2B0r5AgKjJTP+PUIqzZtVb1
	 R/PcuuXUv/SBUtjpCCVO5kxSmQ4z9hpU9fuIPB2CQY+nDbd5/cdcfqQwBPLHrPjhar
	 oIqyQWDfWFatlfrpLsqVvGK3g8is5KCkw8MoA7NSOo+HmmF8ZWp+HUTbJscsvBOcmJ
	 MehWEeI46vwgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 82F28606DC;
	Sat, 12 Sep 2026 01:07:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E2BE3E45
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 18:19:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D4AC080EC0
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 18:19:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2hQwEO4JFAkn for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 18:19:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0516780EDC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789150744;
 b=gLJCVHlr6h5kr1e2hKFfgm1Tw6aOvG1HZEMlnsBazNHIuBNe135YQgYHnKXxqXY9LoBP
 G0hpnNQUE9pfp2x7E8BzmiGbvE5jFzyiS5CR/SnbcLxHyvqQzRSRUUYDm/qTbyqGm+zI+
 Y69mNfrcuRhVAPq2lav9Ouv0dA/BzUggpvsXlFyJq8l+RDyMWmig2TCewxF5tND9EOJjG
 QoUJTeth7WFSxri6Xw3zqKhkJe7sMXwR7w6WSO47TUbKSbPHODbPAF1nrfPJNPXcntSvV
 YMgoCL7PWXaWQiKM5FI5H98QGq1Iy3DnmK8nL9jieEUYliRa7RdZZOBPGZEO1blTncg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789150744;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=dUCrouaQS2dyNydaS9lFgUSuIUdM/7DT0GmGyVMeNo8=;
 b=frU7KD4HNspvBaP3bH8aIyUm1LaT8O8ED7SAqRz4hX8kh+4Aksbc6+952+ffLH+/SEC3
 GSL+RBIyzDYmVTxDTM7hEcUOo4taKg7rpRreJujhHPoSZQmCr0QwHHi2XJkAFc2EcKlZH
 h0QglcaUnfDy2hdjujNeDlKKBhFgZDLp65kjLZs6tN369Mq7UhxSBBwwQKXMF5rQuQ2qe
 dFN/JRbpYJHfmsXJoYkuWuRr67pC+055J73mTnvuybAMeYWhAGJTVcfCxIhf057/B6Om1
 txP3DMiIcbWkyHxzP62Qqcp9ftQXIjjix1QN6no5IqWZhn1eR58Nl6zDMUCY1jDntFQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=i7J5yoTu; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=i7J5yoTu
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0516780EDC
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 18:19:03 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id F1F5B60142;
 Fri, 11 Sep 2026 18:19:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A72F3C2BCF4;
 Fri, 11 Sep 2026 18:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1789150741;
 bh=VETHFUxNsELr+h0xv2QWqd7fmsUY+FZWCdNBNE9xdZU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=i7J5yoTuiXwv/QX/SIGqW57Owi4kd8VKX481IlVpJlBnEf2q5WeBtBeMxNxscBAlv
 bap0+zWoZK9JdtKrMoZqnPc26m9rjZtL8nx4x5gon8ldIhZFa8UtBfHTTA4bp+6kk+
 nx0Js9qMggjPXgzV99tLvgfvHSonQ7qdgqJUc2dOiFwkunl/h2lSV78h8FvYzncXlr
 miBOVoeUFkFyyM0IY4FsXQKs/t/KE/4XTwqt8gG8LkkUwZuiNU/qywGvvSTIGi2KPR
 hof9T93bxVDw0+cF2j5Mp0LkRMwCmK9WxeLZrYeGzBvweRdwPYkSlWcTWvdIFUrSKA
 YrQXGHTGJL4og==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 8C078C88E59;
 Fri, 11 Sep 2026 18:19:01 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Fri, 11 Sep 2026 20:18:48 +0200
Subject: [PATCH 2/4] common: Add command line parameter masking functionality
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-b4-android-bootargs-carryover-v1-2-6ebb43da3df0@protonmail.com>
References: <20260911-b4-android-bootargs-carryover-v1-0-6ebb43da3df0@protonmail.com>
In-Reply-To: <20260911-b4-android-bootargs-carryover-v1-0-6ebb43da3df0@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Kory Maincent <kory.maincent@bootlin.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
 Alexey Charkov <alchark@gmail.com>, Heiko Schocher <hs@nabladev.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Anshul Dalal <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 David Heidelberg <david@ixit.cz>, Petr Pavlata <petr@acrux.cz>, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789150739; l=4681;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=x9zxeiR0oC68kj6krUFAO8+pGh69IAz5yDuBqH8tHJ4=;
 b=TOYFTGNY/VpAUvfmwFBjv9cm+dtGg6/vQ6Th37r9PDaLYDHJsgjWmUFNmcg3qodEtKf6mBL7D
 PJgZ6VgxqNcBNF0CsoekWlvvX9OeFGpKwXfzkGmqZdrABUuk4WYgZZ1
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sat, 12 Sep 2026 01:07:23 +0000
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
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

Extend cmdline_utils to support masking or replacing parameters in
command line strings. This is useful for filtering sensitive data or
modifying boot parameters.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 include/cmdline_utils.h |   7 +++
 lib/cmdline_utils.c     | 150 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 157 insertions(+)

diff --git a/include/cmdline_utils.h b/include/cmdline_utils.h
index cf127b64e55..fa6e20b2417 100644
--- a/include/cmdline_utils.h
+++ b/include/cmdline_utils.h
@@ -18,4 +18,11 @@ struct cmdline_param {
 
 int parse_cmdline_params(const char *cmdline, struct cmdline_param *params, int count);
 
+struct cmdline_mask_param {
+	const char *key;
+	const char *new_value;
+};
+
+char *mask_cmdline_params(const char *cmdline, struct cmdline_mask_param *params, int count);
+
 #endif /* _CMDLINE_UTILS_H_ */
diff --git a/lib/cmdline_utils.c b/lib/cmdline_utils.c
index b4798c439b8..4355bdd45f4 100644
--- a/lib/cmdline_utils.c
+++ b/lib/cmdline_utils.c
@@ -94,3 +94,153 @@ cleanup_error:
 	}
 	return -ENOMEM;
 }
+
+static int ensure_capacity(char **result, int *result_len, char **dst_pos, int needed)
+{
+	int current_pos = *dst_pos - *result;
+	char *temp;
+
+	if (current_pos + needed < *result_len)
+		return 0;
+
+	while (current_pos + needed >= *result_len)
+		*result_len *= 2;
+
+	temp = realloc(*result, *result_len + 1);
+	if (!temp) {
+		free(*result);
+		return -ENOMEM;
+	}
+
+	*result = temp;
+	*dst_pos = *result + current_pos;
+
+	return 0;
+}
+
+static int write_replacement(char **result, int *result_len, char **dst_pos,
+			     const char *key_with_equals, const char *new_value)
+{
+	int key_len = strlen(key_with_equals);
+	int new_value_len = strlen(new_value);
+
+	if (ensure_capacity(result, result_len, dst_pos, key_len + new_value_len))
+		return -ENOMEM;
+
+	memcpy(*dst_pos, key_with_equals, key_len);
+	*dst_pos += key_len;
+
+	strcpy(*dst_pos, new_value);
+	*dst_pos += new_value_len;
+
+	return 0;
+}
+
+enum match_result {
+	NO_MATCH,
+	MATCHED,
+	MATCH_ERROR,
+};
+
+static enum match_result apply_mask_param(const char *cmdline, const char *src_pos,
+					  struct cmdline_mask_param *param,
+					  char **result, int *result_len, char **dst_pos,
+					  const char **next_src_pos)
+{
+	char *key_with_equals;
+	int key_len;
+	const char *value_start, *value_end, *param_end;
+	enum match_result ret;
+
+	if (!param->key)
+		return NO_MATCH;
+
+	key_len = strlen(param->key);
+	if (param->key[key_len - 1] == '=') {
+		key_with_equals = (char *)param->key;
+	} else {
+		key_with_equals = malloc(key_len + 2);
+		if (!key_with_equals) {
+			free(*result);
+			return MATCH_ERROR;
+		}
+		strcpy(key_with_equals, param->key);
+		strcat(key_with_equals, "=");
+	}
+
+	if (strncmp(src_pos, key_with_equals, strlen(key_with_equals)) != 0 ||
+	    (src_pos != cmdline && *(src_pos - 1) != ' ')) {
+		ret = NO_MATCH;
+		goto out;
+	}
+
+	value_start = src_pos + strlen(key_with_equals);
+	value_end = strstr(value_start, " ");
+	if (!value_end)
+		value_end = value_start + strlen(value_start);
+	param_end = value_end;
+
+	if (!param->new_value) {
+		*next_src_pos = (*param_end == ' ') ? param_end + 1 : param_end;
+	} else if (write_replacement(result, result_len, dst_pos,
+				      key_with_equals, param->new_value)) {
+		ret = MATCH_ERROR;
+		goto out;
+	} else {
+		*next_src_pos = param_end;
+	}
+
+	ret = MATCHED;
+
+out:
+	if (key_with_equals != param->key)
+		free(key_with_equals);
+	return ret;
+}
+
+char *mask_cmdline_params(const char *cmdline, struct cmdline_mask_param *params, int count)
+{
+	char *result;
+	const char *src_pos;
+	char *dst_pos;
+	int i, result_len, cmdline_len;
+	bool found_match;
+
+	if (!cmdline || !params || count <= 0)
+		return NULL;
+
+	cmdline_len = strlen(cmdline);
+	result_len = cmdline_len * 2;
+	result = malloc(result_len + 1);
+	if (!result)
+		return NULL;
+
+	src_pos = cmdline;
+	dst_pos = result;
+
+	while (*src_pos) {
+		found_match = false;
+
+		for (i = 0; i < count; i++) {
+			enum match_result mr;
+
+			mr = apply_mask_param(cmdline, src_pos, &params[i],
+					      &result, &result_len, &dst_pos, &src_pos);
+			if (mr == MATCH_ERROR)
+				return NULL;
+			if (mr == MATCHED) {
+				found_match = true;
+				break;
+			}
+		}
+
+		if (!found_match) {
+			if (ensure_capacity(&result, &result_len, &dst_pos, 1))
+				return NULL;
+			*dst_pos++ = *src_pos++;
+		}
+	}
+
+	*dst_pos = '\0';
+	return result;
+}

-- 
2.55.0


