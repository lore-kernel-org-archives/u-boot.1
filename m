Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2236606A329
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 13:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aoBLUH6G;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SEks8sjW
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5792581137;
	Fri,  6 Nov 2026 13:32:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q1rjFGnmjxhA; Fri,  6 Nov 2026 13:32:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 76AED810FB
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793971922;
	b=YGAaMPwS6KpROB0XbQZ6A4Q6gc8UJ+yfiZhR4ID/KDPOEAH2RXkCEXUMXd6QqjeVI9of
	 AW9JlbKBLxcOGesahnSuO/tlcMsie5Awf0IbjAz/dtCso0ZIdhgi0ukaVAALpGKBgAw7G
	 ZpB+p+uKTpQJ8QV4GzfNX+TR6nlK7wVmJEroMG5+5pI6Q3j99hfv4x/lq/E0RvoglobFc
	 ZGsrwVKl+RYg1Zz8xjTeUVPrzRrKDLzLP9LTQepbScoJHmO3dWfNDLKZLQNQwf1s7X0Za
	 HYjNB8r9fQLXea2FoHrOAM5R2eJMyds0wpTCJ3VOl434fonaDdidJJBf9/O/pEeYaQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793971922;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xRAaljTQXX7Zj92KXLqBzENoBipQGd+cPhEy08RTgC8=;
	b=Sz91qGqde/zbq3+SJFghJ9qAX3KVq2iPcl50kg2GqqxEDUz80YNid2IQpMRBE06nDZxO
	 20z/Lb2ay9dGjrjBE9lL/MJiWQrH7b1buJZU6eeyTag/UXVQdc03BA/HXNcxd09O90zAq
	 pYJU9yymXG58Iw8VT/rRhKOMvJcX5PLnFyAdMCKXPXWCI4Uln/O7FR6Cmy+khqZ6UW4eI
	 dG7RuRKZGxxSuDKY8W4cXTzg0pTy1ypf62jnLfvsTjJk3I0C9/1qpLVNGyLeT5Y4jx9TY
	 0ar4HlZnlT0kcAUXcEFcazTMwE3jsB7tfY8EgYwqG3yTaTMOC8foen4KyO7LqyCTrLg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793971922;
	bh=xRAaljTQXX7Zj92KXLqBzENoBipQGd+cPhEy08RTgC8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aoBLUH6GvFKPtUyGTPCADG77FX3xLq0hP307KhpHH+UoHI3VqarSEjmoeoeQrbanZ
	 sbx8CaTSXTlCVPJgDvXxC1Cak9ajp1Sl90jW/NQKCWG0xdvtHcuY2djM+0hcBhslOx
	 N7EZWZS8oJ98vI/OAAliHd0xAx1JXqnQ/IFsXuCB2qg1kkncEP/F9QK4hBUfZLp7Sk
	 eAH1Mrou0wh0Q5hIYMBFg7Cyu4UYrRuc4apjA9y9RgclTa4cTJhwuBYYZaZF82NGrn
	 heb1KbCOlJTj/bHJfKl/MPpkifyhxqqK7gYUsB00Om5k6GmwQz4ncW2MFVH1Ez99P3
	 5e28EvTt4Yzhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 76AED810FB;
	Fri,  6 Nov 2026 13:32:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 510282AC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 13:32:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4EA30400FF
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 13:32:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Ob64dpd2MD2 for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 13:32:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5832F400CD
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=SEks8sjW
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5832F400CD
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 13:31:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 534C043DE2;
 Fri,  6 Nov 2026 13:31:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B649B1F0089F;
 Fri,  6 Nov 2026 13:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793971919;
 bh=xRAaljTQXX7Zj92KXLqBzENoBipQGd+cPhEy08RTgC8=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=SEks8sjWZtNWmqdf2e19Jr3zyhrX6osJyTaK4ichqdbHGlE8XOutJFFtMfMDs+HEL
 g/XHlIzbR5zAoYGd4v9ZDh4IOf6OWgmLJuB49Xi3fbKvhs+Coh8iNT0/8FVeNDmJci
 vHGM9uKsxIz36nHj8Xq05z9m3bmZw1ebPPQDdjMD0OhwRHFng5D18UHBdiPafLjEQP
 Daf+TxRCqDa291LmwzDcSbAKs2GChasFjEj+vSa6FG8SnOzIHTXpskWUnKvRlcHMxp
 OZvw3XrjuPfVjGRZgf+XPQxsfHhylxrGo5ILm1CrUjn0mFKNEpPLwdfUCfoFF74kDw
 iwFwhAaK6gQHA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: u-boot@lists.u-boot-project.org, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Vincent Jardin <vjardin@free.fr>, Petr Hodina <petr.hodina@protonmail.com>, 
 Bruno Banelli <bbanelli@gmail.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Jan Kehren <jan.kehren@emteria.com>
In-Reply-To: <20261023-upstream-libavb_b4-v1-0-97ed25b09ed3@oss.qualcomm.com>
References: <20261023-upstream-libavb_b4-v1-0-97ed25b09ed3@oss.qualcomm.com>
Subject: Re: [PATCH 0/2] libavb: resync with AOSP 1.4.0 on U-Boot's SHA library
Message-Id: <179397191317.1028119.7293091746715377145.b4-ty@b4>
Date: Fri, 06 Nov 2026 14:31:53 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=956;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=ecWByYv+3N9K+046NejV8hcHt5M1/KMK4NQnE8z9N1s=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq7dbN9LoB4ki6bICWJMVF83cnMnHfF+UnIphaI
 9UEns2FFS+JATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCau3WzQAKCRAZDR20Zk4Z
 NUztCACF1om8CoP8SUpunuPESmPyVlLP2JNfS1rdzRywCXbYEi6mhaapENAnu3MCWS51StOchPS
 C+Bh5kQXpgXell+hXsDozXed2NjvXfabYEq/P3xk++qnlqCq8fT6dj7wKutwADUOe1i/ZdktVOw
 7VJgFXY8PHNOD8rPHQP+/zwLVvfFz4g0EpFhDojS2RNDVXBkunnBV87ELhPQWO2ubAc7bvhSx/4
 eQ01yM4Cc5MZgjI4liII1BKo36olH9q9XkP+DkvVSkSUHcGyk8iZ+ykXMX6v+DY7waIG/4DtWuH
 IoY3gAkOVC4NQ24wsZMYOWDjY+KS+i3f54Rssjm9mE9Zu4SF
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
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Fri, 23 Oct 2026 21:50:44 +0200, Igor Opaniuk wrote:
> libavb: resync with AOSP 1.4.0 on U-Boot's SHA library
> 
> lib/libavb is a copy of AOSP external/avb's libavb from 2023 (1.3.0)
> with U-Boot glue. Upstream has since fixed a verification bypass in
> chained vbmeta partitions, a silent failure of RSA verification on
> allocation errors and out-of-bounds reads in the key parsers, and
> added the vbmeta digest command line properties that newer Android
> releases expect.
> 
> [...]

Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/2] libavb: build the SHA functions on U-Boot's SHA library
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/9450a497dc03744fc9e4b40cf8de20084921dc24
[2/2] libavb: update to AOSP 1.4.0
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/cdafa8448ed4487f663ad9e026116a9baf8ca688

--
Mattijs
