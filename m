Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2E1606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 14:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Guvco/u1;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J66AS4tV
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9527B8121D;
	Fri,  6 Nov 2026 14:15:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 433R7yyM6lir; Fri,  6 Nov 2026 14:15:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E8F4181201
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793974547;
	b=KcKm1PscRjosYQyR3pr2WUfW/266D4/z2afreeA1FjJdznqvu8lQZwSM+J7FtQbu9SGb
	 dfd5zeqJBBeCJqFoILTjYPHo/XcRBxK7e2eQaZ9hvt0WXBJoYOGRFsQpS5KhNP0nRchQf
	 mNSHClp08ZPFDusVVLAOuFTnhx9CBywyuTYt20YDNQ4xmA7fY6nc0V+j+Hmxb+v6dBaj4
	 DE8pnmK7tQ8DVi+CH2FFcy0j3Jm4xpt0PaExC4FbJR9x+L1LfkspT14V7FOsrri3u6PiP
	 AmnvfgxTE/wDRKmfA4rTpEN92+ZGZhsTTjmCXomrRoKXAIPdyfKZSKPCfXb8VIPrMJQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793974547;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qVeNV4gQzZ2JWwM4gD65Yw0tmvPY6sgxMDZ74FgYKOk=;
	b=Q+JzBcoSFhLglcVWaVaUSbAPXHpLj5h69E3KA2lVm8gGerHLTnAX3J0reOz9AfB6ymXS
	 3ObviOfNyFfz3Vl+sGkn9Xqi/dLKrXecrOEYf+pzoZJfh0to/OorGiA+08B6P5XJzL7/I
	 F4DkoAqBNwRFPz4M4D2HNGHgjdaSqjfAOI7XZd9eS13RorgceOKAW0RAL/afQWZsdMCQa
	 yzI1faRQ+8ZDgRf0J/Vv9pW7sW7u3oaLN/MoDe7Ln8Hk8+/FrzizA2QW0MW7oAsVs3fvg
	 y7WnxmGYPStcJ63KJa9aI5BrWt9iKsMsFMm4BUqdRwrcuzDrcv6cGednz1o2kmQLOew==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793974547;
	bh=qVeNV4gQzZ2JWwM4gD65Yw0tmvPY6sgxMDZ74FgYKOk=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Guvco/u1J441OOTAqvmgLaQdvztOjiQ+Z46dCiiNXjQOnvKYAjbjydfsW47+ki1Y/
	 kMNnN42JmzRRI1flKCFvM4QA4JLlQeG/DZVVChCP1/UqonGcdECTfsdSk6QekOaJ9U
	 WaNNslfO4HYIXiqJK5mwCbYqLDonniPCiD9yAO1cEZocyEZIi6Ie9vg2XMzsZDO/us
	 322fSdO71k8Fsosa98qa5pEp0a5gfmzMzMqGuppy2/xED3MNKP+Z55at1GgIK9VDnc
	 byfuR/8QdYcyLTXvvqdnV9Zbg+Gk8+SlhJxXAEBwq664GP5IxtVgH1imibuyq7i0Uu
	 YMYtSDMbGZY8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E8F4181201;
	Fri,  6 Nov 2026 14:15:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E4F5B7AA
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 14:15:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CACD6400FF
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 14:15:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4XJV516dncsB for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 14:15:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9711E400CD
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=J66AS4tV
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9711E400CD
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 14:15:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 203A741286;
 Fri,  6 Nov 2026 14:15:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8D11F008A1;
 Fri,  6 Nov 2026 14:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793974542;
 bh=qVeNV4gQzZ2JWwM4gD65Yw0tmvPY6sgxMDZ74FgYKOk=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=J66AS4tVigzwbDbUqbC8+n0kSSm/boj8l3s/KySyzj3eHkhSsBV/VOYWwl2gUXDT1
 0ttWa7KQKgZ3GwJWzOAAMypEpVYvH6dqoXvtM1oPY84mfCfUH2E0OQg0GK/XrCD6Rg
 KRorGe0giUcSkpNLCSIJBMYUIAijUm/59MM8EZ3E/8oUMMZ04XIprrFDl5SyzT1oFz
 vAfeGRt9eOqVOcSCgsINr4VIAYJrAfe3HtN4RBMgPstQH6bAlp2464U7Ax4Mh83roW
 2fcgGYmnpR5jFMwaMgCnnnsg7hYoswupBIZc3XbtkPyCaWUTFCsVN9db6H6ZJ9Krfg
 zodaCPRoxGsgA==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 3/7] usb: gadget: fastboot: do not boot after a
 failed acknowledgment
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Carlo Caione <ccaione@baylibre.com>
Cc: York Sun <york.sun@nxp.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 u-boot@lists.u-boot-project.org, Sebastian Siewior <bigeasy@linutronix.de>,
 Rob Herring <robh@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Francesco Valla <francesco@valla.it>, 
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>, Sam Day <me@samcday.com>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Alexey Charkov <alchark@flipper.net>
In-Reply-To: <20261104-ccaione-upstream-spl-fastboot-boot-v2-3-cf9781441ed5@baylibre.com>
References: <20261104-ccaione-upstream-spl-fastboot-boot-v2-0-cf9781441ed5@baylibre.com>
 <20261104-ccaione-upstream-spl-fastboot-boot-v2-3-cf9781441ed5@baylibre.com>
Date: Fri, 06 Nov 2026 15:15:31 +0100
Message-Id: <179397453139.1035345.5564878043677289723.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=393;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=n34eRRpTkt/6WSp86vHo+N30B33rz/ndUh9PZ5BjJRA=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq7eEIDbFGZH5ijRoJrySrZaS0PRTiVbEZKD9yd
 x5cyrahRe2JATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCau3hCAAKCRAZDR20Zk4Z
 NfdRCADj/kgwZSa5OfFVDO22qBwo8WO+iN9FCMczoocIFfDOXc1vXd1is6ZUah6lbc5ztiNb8p3
 Yr5BwFAD4k1cB6bCKkAiZNU6NrDINlB20DenyMWNyFBm607OqVoRyKVlhoJbhqHO9IsQuwZAJYz
 wYQV6PoDFdoJ9nPXeArYl9Yri6Y0TH1zQqqnJAl8+7+H19z+o8g43XrCDyR5JPKi4P+UJBsuDzR
 Xm1G5zW3WmKXr94KR4PpGIyAYoIR9WkasVFy0iSOcjTLwyYSPV7J+FXvOFzOpfbgks2x9R+REFk
 8oBcAS4H++OxaTBSYQ+4mmP6M0rW1e8K86Z9P/ZRrqkN0UD1
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

On Wed, 04 Nov 2026 10:40:23 +0100, Carlo Caione <ccaione@baylibre.com> wrote:
> A failed transfer of the boot acknowledgment must not start the image
> or leave a boot callback attached to subsequent responses. Keep the
> session usable so the host can retry the command.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
