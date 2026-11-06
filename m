Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E22606A329
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 13:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nUqTntdn;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cqgYP1yC
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4097F811B9;
	Fri,  6 Nov 2026 13:42:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u7CSxcnz_8VX; Fri,  6 Nov 2026 13:42:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9AC7F81134
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793972522;
	b=cru8q1h+WsjfZj0tpAdzFy/NTHF31hBXGGtdtIO/Mo8xN+yNHrn4hcv3pG61BRtNnlnD
	 L+8PFPTEFCDdRqlAdTj9VRXDcbMNTTuYf0zdVsylS8HRj48+YDRWXSW79l/5yskpxdE71
	 hSU62jb/279HsU6ArBqhhNOs6Gxc5ZswB0NUZD/pOugvh/ecU/YkYlNMNVhESoejcGKlm
	 8HTM3MVsbRgYsc0N+Ykz2AWDApOLVhJxWTOsozDYCw3XqYu6noEeEJvq4RUs0PFfscy5Q
	 9+c0dXGn+mLFGqYG8pTB+fGOegl1J7kd/nhInz/PEK0sKW73Njz/f3jT6YFe8hrJbtg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793972522;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9w+OYK93XKuCxZYPrmk3chy1q4tHAKbZ+14swWSR3qI=;
	b=nkdd825TLOMq+J18D3mqC+jX6lzztLaZkO5vCy5bSv5RKIOCs+giwlqTOKqQ+LwZZ1Ds
	 eiIwdoiL6ze3A4MOXY/sn+uGAEojhN6iB0GbKU0NvqlGh89vPLaUtiDxT6eId2BSnvipg
	 Jng3jvFwZyEAKzwvX6+ID/t2giNVfqn4uAhNrCg8BaY6wZqQp+TH674rczG42XjaQ7IUC
	 nAwgWhhxcNJPZ+HF1AgNqM2qyf7RPksjYcZcKRaWnQa5lKOF8IH42OkZbYcHruSKjLVsi
	 0SULAsq0O6iyYE9qCKG9UqpiSDpll30F95Dk6xOEeGqyevI/mMQ+u1w/gEG1zhfwqtQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cqgYP1yC;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793972522;
	bh=9w+OYK93XKuCxZYPrmk3chy1q4tHAKbZ+14swWSR3qI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nUqTntdnOeID+A7AE+eGnAoLpFtFF4sqhxTDuNy+JXqpJb5OzOaJsCORSn1hZ0fgv
	 3IzPU0evhkrEoLY0B3oHmFdwRrpMKBw9fc5rnZWHJWuT5/PHi05gCKbJHspISKSmfS
	 VhgkGv+kGcHnJELHzoTFJS5DjkVrgxaY+xvNIg7SEZAsH9QOhCU0uxUzl+7911OzcD
	 wvSWOrs6Wyv8n9hGEMEn1FQcOUeB7HYLx/Z+uH/5Q8Sp58cobe9TeKl5r7ghsWkMBZ
	 FOqLF+nx895uCZ5LH8sK2o8zBVqkbUb0Tbzj03lcwnbeSQnYq3w5E59oXCk90wckLN
	 H4tmq9vU0QWrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9AC7F81134;
	Fri,  6 Nov 2026 13:42:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B55407AA
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 13:42:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9B561811AA
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 13:42:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wqcKZztxyMBK for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 13:42:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E074081134
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=cqgYP1yC
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E074081134
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 13:41:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ECB4843A03;
 Fri,  6 Nov 2026 13:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3C81F0089F;
 Fri,  6 Nov 2026 13:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793972518;
 bh=9w+OYK93XKuCxZYPrmk3chy1q4tHAKbZ+14swWSR3qI=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=cqgYP1yC/zM4P9KSf7qc2lOh28saU/bWtL/eDNVck2HyuDYiWzqVlDIwhfjFrlU4Z
 jNig0v80F0gKZEHDL/yGcTN3EcIWr7mWp9eapN/tpRihIgWNkzADaX9bm6BarwSUlz
 trQ5S6xQ8s2Y1W61GwH9Bkupm2U94bHoesRl9jWxA+/K6TskmTJi97vHasPZ77X/de
 tJhZag5r7IoNpU7gWyoUzIIlW5WONpgiweM1A1p/7twQV+m+eLEMEnaPyGvFXcaNq/
 eVhdFSsYnNe7AdCZBu5S1QL+kjZKGPvNzo8WkWn+TLQZaHKUUqyTOa8O+dEZ0nAIdI
 fKizSCEfhjMXA==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] bootstd: android: load and verify init_boot
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20261029-upstream-android_init_boot_b4-v1-1-30c95feee363@oss.qualcomm.com>
References: <20261029-upstream-android_init_boot_b4-v1-1-30c95feee363@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 14:41:54 +0100
Message-Id: <179397251407.1028119.9091829972516830659.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=987;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=qf2uV1aLqa/eFxRjH+Lx6fTtL9Sw6xktYbh68lmDr+o=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq7dkkh3Mfxrg3SuKKgL2GVlRSiRqqL9aO+0UFQ
 EYpNyOYb6OJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCau3ZJAAKCRAZDR20Zk4Z
 NUBaB/95pl26Eil4fePhsG22zO80+NMQeCRredbOP0P1gHCZEmBsTlDpY+u2Fw/DlcUfWz3LZQb
 S/yi+j6lhO0FKX30yZdri6Sxcpf+ZBBNYV8WGim/fqanlvCxRSxMpIeYYzWRlF4qeWrG36Aj7PP
 2v8OlamavqXbqnfL/HQ0Y4veCOyRJ8Y1yN8oceOE4PsInAtMm1nrIkUHNRanxpg+QnqbHOFLbG4
 d9C33IAb7G4eEr94vfTqZxUW0DFVVGAndVQD3WKecHY+FCXH8yOigFICRU7ur8DQQdwSsZ7HyUd
 kS4yddOZX7OclTRunDeMJukFRBqV7NyfiK86LttkfynW/0Dw
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
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 29 Oct 2026 10:20:19 +0100, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:
> Since Android 13 (boot image header version 4) the generic ramdisk lives
> in its own init_boot partition and boot holds only the GKI kernel. The
> bootmeth loaded boot and vendor_boot only, so such a device could not
> reach init unless its images were repacked.
> 
> Scan init_boot like boot and vendor_boot through a shared helper (the
> header is the boot image header with a kernel size of 0), load it to
> init_boot_comp_addr_r, add it to the partitions libavb verifies (as a
> preloaded buffer, like the others) and hand it to bootm through
> set_ainit_bootimg_addr(), which then takes the generic ramdisk from it.
> A header version 4 device without an init_boot partition still boots
> with the ramdisk from boot; a broken init_boot is an error.
> 
> [...]

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
