Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167A5CD4F5B
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 00:12:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42C0C84894;
	Wed, 20 May 2026 02:12:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hXgFFZ8L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F141B848B7; Wed, 20 May 2026 02:12:42 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78BCF8487C
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 02:12:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-439cc157c21so2042024fac.1
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 17:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779235958; x=1779840758; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=vu8MMqvWlncvckvxJ+KpHaWFYCb53OeHLvRITtt6M0Q=;
 b=hXgFFZ8LNeHMjtr92nnZvK/ZW/00mjI+WfRJPv2q1+XzFx2Nwaqr8msDiCLkr2gk2w
 qeJrHb+cWl5L+D/s255q7uTArO56J15GmKU5h0X4SQuBiJiX4C0zdBpCW3dogZRB6atM
 ska1IeCr0kVGG4FBlQoAcGl9ObQNl6S73tQOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779235958; x=1779840758;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vu8MMqvWlncvckvxJ+KpHaWFYCb53OeHLvRITtt6M0Q=;
 b=Hx16TiuolNDQP5BMc3rAvkTHwqrW7ioNudNo0zLm5b/lU0d/YuWA8kDV7lcFDF3m01
 ab/YrVV4lU9No4QbkZ+zRge1F+Bqwmlsmzego4fohunWmFfCeYJmJdRl8Aeym9aJtnzy
 9WU1G5xJcpSvWnXwormWhkClDFIVX7iYjV6vMzEOoWXeUHmfwPr+LMElRP2D6othv+NG
 Y7WcbxNNq/w++QLfsl8ZhTMssikqHEtFkIAQAh5EmXkKrh1i2eVUKVR/SLiiu2YTkLA2
 Uv+ONNJmcZcUIGpdHR9aILXbe0sM8OMGdkGj9+ivyExWXs75v+Poj0v/r4ib4UHs8EWy
 gHsA==
X-Gm-Message-State: AOJu0YwhqcOETeNnIfzgHODebofpNTRN//T1E8yiwTDMs3nzOpCNnsLr
 T4syJK/6TZiDX3czAccSmc6Sp9NsAvI+V2tEpR1ORV2EclRqYINIMzaV27fUFbunH5diRP7IDUc
 tYncDiQkJGjTC
X-Gm-Gg: Acq92OEUaiJGvoshVZW/G+kd607jFIlHR6tTd4tOpdvK2lhjxSHcV32nC47BjwR6crM
 vSP+4PrmqVzkTF6S0md7uRcYvzfIKKbx/Uh7+kupupD6DW5LKr1erbZUHJY8yDrR7OWzKM96qcg
 XfB6+jGZksf89lLDntakPA4jdABzCK7EBoRZtH8rphJ/PyOYkeSY5yNN1Lbs8h/4uqPvanGbKIW
 6oCct2X2Dd1ohJ5cacFSAW0gMMyVnyZTSulOB3qGlwC1ECxuZ5WcaW7NhGNgmopqkjMjmRWZLRs
 lcaEI7aQBuOZFOIbrILdOZVVU6AvZfyFT8KJFIgqExAhT+VaE0RgajcVCJSpAcJlClAHxOnGt2a
 CEbELLIXrcZTgoMVCq/4RBNBH/hu6tWKOco1HgnYwaT8wUNrwnyJyKGytwcT4+6gpQju3LuzkGw
 D2xC+38EuXXxua8OUZ2vKio9Mx0bNPT0QuhZCE29BACmnov1BQLMctYEioK1hQlGWhILBqKkRD/
 tjl3YCdkvibOkksTkLk6xs9SFbDT/iEuy30V4azs35BF5ceAVLT3GxJOkYX3E9M+Z1QwBnCw1s=
X-Received: by 2002:a05:6871:b1e:b0:42c:5ce:3fbf with SMTP id
 586e51a60fabf-43a2da0fc30mr13498468fac.13.1779235958089; 
 Tue, 19 May 2026 17:12:38 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-106-235.totalplay.net. [189.203.106.235])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a94fce014sm8859863fac.7.2026.05.19.17.12.37
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 17:12:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 0/3] Cleanup some linker list usage issues
Date: Tue, 19 May 2026 18:09:51 -0600
Message-ID: <20260520001234.1555120-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hey all,

In looking at some other issues, I saw the comment in include/event.h
about LTO discarding linker lists sometimes. Upon further investigation,
this was a sandbox-specific problem for which this problem was a
symptom. Also, the linker list code has always marked itself as "unused"
and while Marek thinks this might have been due to warnings at the time,
that is no longer the case. This series corrects sandbox to not have an
issue with linker lists in two files, stops marking linker lists as
unused and removes a now obsolete comment.

-- 
Tom

