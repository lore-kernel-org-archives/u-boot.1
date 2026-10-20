Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9F2606A31D
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 15:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ricXqo/0;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=h8US46wR
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D67AE810C1;
	Tue, 20 Oct 2026 15:07:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yxEKcUbS4ORN; Tue, 20 Oct 2026 15:07:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 37BDD810AE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792508875;
	b=XNkjPD3CqvuDIO6QkYMycywT8kaxoV9AjXb8On1DuY55s1Ihq+ccWsorTGegkYpcOKTL
	 yC+UDSvFs77q/Ar75ZoL3ucFj8ld9GTEsDT7q9oE6tbID2wC2Rx8FtE3crT5jFtbqutkw
	 hGuCUj8AaxZjybE/QgS0swR2QwrZHwXApo1nzk1uJaUa/Z2Uhs3u1BzOGEsTSQKiLC3H4
	 DG4dVq7QZSxzGkcOppK6ThXZOajH8qKfR8L0Q5bvSPRQlEmbueWSVUZoomTdEGnfWWgyb
	 XndykLyN+d3Tuh3eNrGMOsPQQbZpvWnZLLSn6SBtaFyIg2GCuFwsfJ9imrC516ouQYw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792508875;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=IacbS4qsj1EV2Qa4KE5Bs8+u522ZalbwbmpZllNVbqo=;
	b=qLJlwtWhap17k3yF6aVJ+Jf3xQfqQzPkQIlgCjgDan0E37ttvrtl1XPUfyRCaD3JVf7a
	 ZG+WYODv3deIrOnOvcDeo4nYQDIutNmFGMifTiF1+ZcKMk+M68GruwWS+PvIi7IomM3FY
	 YeSL8dCCIs6940mEimFxYJpnDXxENn43Mb00KGKfMV8yZaX5FWrSn13+bDjydMI/9C0tN
	 BXele1AfTKwVGMYV+2BBSSRA6MbRaiaIV9z3FF4rQtE2XW4tpgp4tDGKXp61fDnuem4DW
	 fxjQTKf9rJ6276UcifoAyTicN1fqITlXV6QS9dhPOEgdMcSVZarBNZxIxtNj6OUGmiQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792508875;
	bh=IacbS4qsj1EV2Qa4KE5Bs8+u522ZalbwbmpZllNVbqo=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ricXqo/0jCFqCPR7sfhJ7rT4IrY8v90oacvgkqqHFLgXGIxQuJ7F4RuoXFP8MeZeE
	 ktrvMxt2Ah3Pz0xin+HkNsQcmTIvUgs4oO/YALnUIoZhMq16pGC//G+FMz3gsyydjB
	 Up74jgy33KN0hG7lHQ8dN1sq5mB9YQzoNURp7WGrfra41GV7emHhr+pNItkfJSZuRt
	 qx2ZWJE02cc5V8VHPY8fIiu6iuFTljRAziUC5qB8iAVu1ec0z2PAqNYAWY2AWV39VY
	 mrcqgr/IKsVPhQeNExMjeVDrN4185mkRBaA8abGR3UE8RUBXdj7LIcQvgGXidTGyY+
	 ceOwOo1abCgLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 37BDD810AE;
	Tue, 20 Oct 2026 15:07:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1F415930
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 15:07:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1101E4035F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 15:07:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E0rarDPKZahs for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 15:07:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 98D9A40359
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792508872;
 b=AgUbrX2YJtaY7Z6skY74WZzRO/sKz7R5jVHHuQizt/mtaZT/gooz7/eHHGfwiTqLcc4v
 9Nnoglvf3Qc6PdrpcIUeZGm0dZE7jCQIYCrZ40MSji6fnbo+S9RIFWTxbxAhZsW0MkL0M
 TX1mBY81Qvho/J+JNwtEZU1WMkSe7qcA9UbN5D5bSyDF369qp3sFeoYe8L3io+w4Mf8w+
 aN7MrZ2kW0eHtZ3G9OfLUX5GnWssCaGg63R0aYsaLs+vnHsTJL3gXRNgr2MfO96yzshi2
 L+2TPnzyfQHsic3u3gOoJwZC1Q6y8lDpw/dc3W/yZW7+w5+l0qZduvJAcHCITVxImuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792508872;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=IacbS4qsj1EV2Qa4KE5Bs8+u522ZalbwbmpZllNVbqo=;
 b=nmKDD1cOfeEfbwz1/aSsa0L7C8KK6DznWlZwor5g6Uy05S7gW52TOudY5WS4eeIyEUwz
 K3y277foUnlAwT83ifD2IHZDIEMtaEJ0ie8cGw+RvtqBGXdbSTyUCuJlBTWld69mO8/Gx
 Zbc9BnH3xF6cPhEMMFxjF/P4B9DSeiL84X5o/9lSJ0MaY6DoTtnxS0gZExFvIi5rAkNuk
 JF0vT9aQYq29Yv1EESwITw8SIuSS6xZPCBUfY5HWlQYpoEjSL0c8V/1Ry1K7CLY4Y8wkF
 IG6K4+s4coAj1+s1eHN5+4nuY/fNdUOXF1dsHCDh6d9qPUJGQfb+EEOwdYpySJSO4sQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=h8US46wR; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=h8US46wR
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 98D9A40359
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 15:07:50 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48df8fe8513so2922924f8f.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792508869; x=1793113669;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IacbS4qsj1EV2Qa4KE5Bs8+u522ZalbwbmpZllNVbqo=;
 b=h8US46wRyKB4GKIyz2b8msLO3czHZBDynQphey7uimAYhsZOWZgXpM8iFSILjzsfOO
 +JKLlZFPLj/ciyQSIZ2Mn/SvyLYY1KoBui1HeJZgzBopBL0JfmdgRk/XoFHgMcm0M8ww
 cIlkMliUKwIFOD7rHslCB+gjthwi3jGQw80RasMMfA+9X1vMYxrhX2Viibz5KmD5Bnfh
 baPj9EH3vN9K0wbd7tTXWPQvL80WfsMD+BTBqj/fIwOL1/aQ7koJVxWsHw8cXi58UOKw
 2m3qWvwMbmN8ttdzBR6tfBHPs6NyhnnwgsbCz5+eTeR5/iogMOW7N33S40zn23JrheAg
 Dyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792508869; x=1793113669;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IacbS4qsj1EV2Qa4KE5Bs8+u522ZalbwbmpZllNVbqo=;
 b=LwLr4G3FAhKxc40IqfOVCfIvOyhW8kJqx6DWQoYD1kJMB72cbB/UEHrdGvnO6dUtZa
 0j5KqfnYIXWJtiJnZORlvqAswJI1wanXRkS67JRh/mzBTC/783fk5ss409+YFusCyvyM
 DDrcEoWkPVYvWLJ6edSPxcg2T6TqPsW6Vkt7huMWSfoDZxeuYHLUycZRtPsyJwJ4LKYI
 dwWrO4pQDYKEXwDlrEkoV5MShdFGhn3FSmpZof/KVSA3pn+YeYQyiozGSa7ZTWNeEEdB
 JCvfzuUMuOD39Z2UpJMYsY6HoexJ2+0rSMQtjmKde19+GDAeHVxJVfLM6OMkQKUIJ4RW
 Kvvw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxvYtStSMTpBmMNAVub55XfpbP2z751sbHWKedzPsglKwyRcNWTAEYXHavH6P/yKqEPsebcsF0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJjnvKmjQr5hqjFyYujjCsdU0LhFSEuhlSQC5pge5vxSnrcRBDV
 08CumuZpwk5rtIdX4KeVZW3aLX/FB0YW6v9fHx+4ViF3asQ3/qIEwsNp0Td5x9TNH9DX/jsZz8D
 hwlRB
X-Gm-Gg: AYBFou3NFf+DPRxtpNAheWaBWqIWjBgA5dwKsotSoBnBQvq/0g+Gwb+2mrBD8HGNHo8
 EWZaOtZ076iad4rNORW2/iqJyLguJ3EHWAuj4jLC1DJiH8TKapHliDkdgGVI1fsocW32g97u+KR
 CVjpk8REHqQl29XM+tzgCl29veNQh8rl/UFHj0bzM/QNcBciyZx9KFO+GKHA/Jpd4/ex1Z6FlfS
 skHnXffleX+j38tls7OrXAomdFyi97G3RbLIf85QEbHutLneC0pL3e4hmq8f/P+xTH3QnExrpuU
 8UZRuDy1SjqOSPRsm6Ao+vSGnSxJRg3YOFSp9n4fHOtrVEs+S63P7Zo2BBKZ+9ZgMZEcYlXnXdW
 +B0VM546wf0EPNPd2ObDTtyXCc5IXVhgkoRpL7tmveZFtAmQYgba0KNmy4jPCz8GnG5O4EEF+Np
 QqLjfty20p2H7w/nDrhoM0lYFbhh5fzxYXoY3zk7fV9ajqNywOzFzvBcCdxun4Rb3zO3Dw1lwYc
 pDJF1hLrycD3JXKfBQF
X-Received: by 2002:adf:ec12:0:b0:48d:f99d:a0d3 with SMTP id
 ffacd0b85a97d-48e07fa3e64mr16200311f8f.46.1792508868639; 
 Tue, 20 Oct 2026 08:07:48 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d8214cbsm6581816f8f.43.2026.10.20.08.07.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 08:07:48 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 10/10] test/py: avb: Fix find() logic when matching
 response strings
From: Guillaume La Roque <glaroque@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org, 
 Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
In-Reply-To: <20261020-test-avb-fixes-v2-10-997f8f04fd3f@kernel.org>
References: <20261020-test-avb-fixes-v2-0-997f8f04fd3f@kernel.org>
 <20261020-test-avb-fixes-v2-10-997f8f04fd3f@kernel.org>
Date: Tue, 20 Oct 2026 17:07:42 +0200
Message-Id: <179250886243.3573513.2079579519484736510.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792508867; l=504;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=D2J44UQbdCCg84CC0k5mVmjRpXuzpuZ162RzNbW8Zs8=;
 b=FWltZ3C2aNeEtz6IEWGC6Jya/ba3ELUKZO63Y+gYDZNjJN8j48wEKTUzA1GiphLGSQNHUnJJE
 N1oPOzHpNhmBe3VqK4dasWJhBSewkvs65KuRfE0KbsIzWaJE/V5Sr5R
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 20 Oct 2026 11:25:59 +0200, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
> The AVB test suite runs some avb commands (such as "avb verify") and
> then parses the console output for success/failure.
> 
> It does so by using the string.find() function which returns:
> * -1 when the subsystring does not exist
> * 0/a positive number when the substring exists
> 
> [...]

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
