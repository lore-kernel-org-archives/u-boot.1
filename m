Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFDF606A31D
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 16:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ql/zC83g;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=L2csEN/I
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DBA8E80F97;
	Tue, 27 Oct 2026 16:02:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uKYDkv9yVBin; Tue, 27 Oct 2026 16:02:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 060DB80F90
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793116946;
	b=fOBACQ2fYiY2n+9jiFnGULRivLqhz998UFWkph59vWB6/szDzZmX2edK5fMPx6XZUomL
	 7nOosIb6DG96u9feKBfVjldnHW4swArklwF7oYuXcPhhZe9Cb2R+iq8vsSpHgETLWReDC
	 3XNoD9Rfjpv7v761qsOYGdL6ST9+6vd4EQV7apq5a64KAaC2sEXnCKubJRI9sUTJ8dmF0
	 Co5w8rCSL5mNI871nom/RK7zekVQy4tGYICpBs01J60+cHXRzW81CFPN3gcix5XugjX5K
	 KUtuxRz0o9FEoj0ZnxWcZPfGzXkpJ4NG9JPD2P6iX277hpzEIF/K0g079Iw2YoS113Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793116946;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=2Fj0NxzF+2utzOVbXbn/IOHdz/vjYSVO7J/o4pk7XzQ=;
	b=CjPRcsVtvzYyw8kSbCcqiqbaVY1z2ah/OOZa03tqK+7dyLgVYVryor+y6zNYVMFG090p
	 NWWjbgc09hb3/oGtgWQUvp/Wn9SePswUqEn5sFSvherKN9sBTYLLntZ4xlBZ2z9M2aek0
	 +6nz0B+/Mtq3t3L9iLKKIHZFmnpJWmgLWmpR8CfaB2D3JgxCqzMBNC4HdLiVBKH6jIv7D
	 8grVThXQZ0+ypSAq5QFHnAYxmPahkS+KrKjLE7gAtuXqMs5p/jTvrtLiFk2vBJYX0G7D0
	 hWcztydmH9y56DCDa0Gqg0chCWcPtEyXRojvAXhaO0igoVL5H/ACnEHf8xfoh89iX0A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793116946;
	bh=2Fj0NxzF+2utzOVbXbn/IOHdz/vjYSVO7J/o4pk7XzQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ql/zC83g45dtvl3P0JQaNv4Jwprq43AxETUbuLydJMgzFhqk8C2JohsuIwcVAvanT
	 /7Q3uJ5a9zDSFhzdsLNqHoe1j+YLD318djOldcIB1A6zOBBmhlO8305c1tC93NfioR
	 Fa+QCaMuKEpYrvLV5W1e8aZNu6EREXFThBjIJLSroBtJxGQAZ4MgHUfctcyJ3hoSZy
	 OmLrJZnkkyOjPxr9tpbZZjniX+1dadJUL/Z54ds7z75F+7oJsFQeIQuhZEG8wq2+ij
	 1ebqwOYVowdK+yu2oww6lka+d4eCVHXX8HVUJG+4tRkv9fURQa3YXyzXm7cEhwm9q1
	 rD5eXOyqtWHtg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 060DB80F90;
	Tue, 27 Oct 2026 16:02:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8883C235
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 16:02:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7A5A8407C5
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 16:02:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TTdto5Vinrzg for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 16:02:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9E44C40763
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::3"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793116943;
 b=nKJZvaCpO/p996+BGn0z8UVJNFEV6nT+U50WND45LVMgW7rfX4YRarqazBFgBhj2a1/6
 wUlpVbaKbmJXBjfkI1E6EbWWUuC3TKwAgm6h0cHljZUlk2/rVpKEJUpiUzlox4O1mv7w2
 9goDj9w7b/f2lujKHcFyXfzmN3kFrctC9s5FCmQ3rLqDwDL59NQO4ElCGGlt7FSy02Duj
 cUbs2R0kXsyh1GAKhGPNaH87TTzbIQPUC7POeP2XV8t6cv1QhWp/13fTXFx1n0F7lsEaX
 zDEvdiNuEyYiDYXAsRZRca8iHMnqJgntIxmGmXTojxsdwC/ernyS5JLEwCygiZp8DsA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793116943;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=2Fj0NxzF+2utzOVbXbn/IOHdz/vjYSVO7J/o4pk7XzQ=;
 b=PAocbtHCRyPfsIj5Kxc7H+8KovNRK18BZjbldyevP4VNphGiuK6oUZh0iPG8GwsDA8oo
 Up3+6gYjR7m+Is1i2ACfbQmUs948WhP1diDHo65NxGuycanlHYNEsKyaG6XAOfv/O9Si/
 UPqAPVMqcnUd+5ZCFdRA5OAuYHmoCnZ7XOXhVl7wA27utvl32ypJBgpWtjRtCL8deI3NP
 8M1vibXRQYP4R5Gs+eU6JOson0Osv0nM86BNUBKoNrrZsSaFzry+kYMRBiw6+5PbjER3P
 0LGtPUoIIH1egIBYAaMr49mEepXvINNCE4AcfTvZbavE99ab1l7vrbmzbdOQ6ZbeQZQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="L2csEN/I"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::3"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::3;
 helo=mail-oi2-x03.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=L2csEN/I
Received: from mail-oi2-x03.google.com (mail-oi2-x03.google.com
 [IPv6:2607:f8b0:4864:32::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9E44C40763
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 16:02:22 +0000 (UTC)
Received: by mail-oi2-x03.google.com with SMTP id
 5614622812f47-5413fa881a9so30845b6e.0
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793116942; x=1793721742;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2Fj0NxzF+2utzOVbXbn/IOHdz/vjYSVO7J/o4pk7XzQ=;
 b=L2csEN/I0dhM0xdzMWuN51C3OaW83KPWedonom79Y/rC0RQcx3/hAAh9mFblHDlDa9
 ltYZ/yxmiVTujMvic/P83Wo3jFkjAsLw6USnAnwMlpPGPTrzFdZ5eyrNyPsXOXqWw0zz
 eeq+s1TzkK7CrOA+l4McfqOEJqWJcb7PDk+ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793116942; x=1793721742;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2Fj0NxzF+2utzOVbXbn/IOHdz/vjYSVO7J/o4pk7XzQ=;
 b=UBREE+hXlvdPjCuMBizGh/lObt2M2hsfw9lJmnazcjG6U4cvsgZMs8lxjZRVQXUipX
 9gE8F8f9F8U27yZipFxtDh5jelFYMVGjaeiExyuf7NeZ4PzIqlCYfqSaC3/N7fL92F6u
 JOQWVM/9oxcZFzpYgk2ip2dkeukSN+LzINNLb0m8fAJCcFSTwnXtMoy16BNSPpEjcSTS
 DnOvBnLT7FEq2CZClNO4lDipsl/bI1zX32As7rJUf958eW8PfclDHagrtT81GJ6FgU3g
 D3vdmyQ70ahF7fMjGbjwTZBoffuqiD3KDKn4edPWaWWBUEdw7BuKhhDaGpnmLEslgChd
 gTKg==
X-Gm-Message-State: AFq9FYLLNWGOInu9d4Ujo6qtCeYycLDy3xVzgZAKHgYkfwiXSLB0PqtR
 qh+pCIZc/EHM5BdCGhQevAVcGJdmPFCXh6hNYJb9gj3kLc6Pf2L7wtE7/Nu4mc7nbAW+InAPNHR
 pSBfThtIwJjnDADg=
X-Gm-Gg: AYBFou0fQ7CzstDxvNn9jnxpbO6Zk064j77XYElmQVAW6SBpiRKlAZtFeW6s9LP7ddr
 O1v5w8hp0lUIPSAvr9tfxnAbhp6fviI73HhDkIFDCFg8G2UwV+1hmUb/8qJcb/6Z4uaLeVQxtUG
 trqjN7E4wggMaZj8Na7WB+CuACOVLXkGjSNatFneZmPymGRA+3khlAnPnR5zG8CNSt9QWcgs7YW
 fdiNXqth/GAN+gRftLmwRfpylHsiomFZ3YlYlZkbeGk4IjQmNahClnm6wRajqZhRZBvUaR6nwZk
 v9ssasnug42vrMT9cT/DiAAtXegR4MFN9eIfoWaODtyb+D4AHfKa6x13B/iwzGiILuMJkGLQp+I
 UnDmGE2yOLkP6reL7Y0kRXG23Ro1T7KZo+sYNyQvJG9kf8yCK6AXqggoUIAD77v17/c5BwugWsI
 fMOeWmCY8XBtyICc2wElKyqUjAuokXny/31ob/aG/WkJNAHkIK6MRkUqyNHaLQkpuCug+lN8hSO
 lwdG0td14nkMiLBhZzoiBNIQ6ekJwIM95N8M1GFKCRvEZ98AK8j9HqyuDY00Lbt7zRvzEMWSnQ2
 8TKmtBfemwIKN3B7b4Z+SB8+8pKYXocfDnHsTDd6mDoUWDBA70u+1iAbrwAko8jmZ+RFXIaL3Sd
 s44ZSAiYKROtEjEBTLt9IWIOEOpUn4oTsthckFG82/8JcvQE5P1RwKz/W
X-Received: by 2002:a05:6808:1802:b0:4f9:595:b80c with SMTP id
 5614622812f47-55c0033d684mr7328895b6e.41.1793116941825; 
 Tue, 27 Oct 2026 09:02:21 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-55c0424973bsm8537548b6e.6.2026.10.27.09.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 09:02:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Jacob Procee <sn125164@gmail.com>
In-Reply-To: <20261026213333.453568-1-marek.vasut+usb@mailbox.org>
References: <20261026213333.453568-1-marek.vasut+usb@mailbox.org>
Subject: Re: [PULL] u-boot-usb/main
Message-Id: <179311693863.2385664.8417628415582066231.b4-ty@konsulko.com>
Date: Tue, 27 Oct 2026 10:02:18 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 26 Oct 2026 22:33:21 +0100, Marek Vasut wrote:

> The following changes since commit 8649a54d301a4d0ac526324c7a7ad2574939ff27:
> 
>   mtd: spinand: winbond: Clarify factory BBM offset in OOB layout (2026-10-24 08:24:15 -0600)
> 
> are available in the Git repository at:
> 
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-usb.git main
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


