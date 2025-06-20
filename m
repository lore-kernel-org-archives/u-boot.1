Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F359FC71155
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 15:10:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3DA382CBC;
	Fri, 20 Jun 2025 17:10:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uGDRSMM7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A78E82CF4; Fri, 20 Jun 2025 17:10:34 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A99580E9A
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 17:10:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4a43d2d5569so25271381cf.0
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 08:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750432229; x=1751037029; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HKj94cGB7Qfm3a0es/oNe9gk1Rpl0uXuCTtRqkzq1Ho=;
 b=uGDRSMM74Vh66ieQzYQQrfrvIwzjqMe0SR068av+udvlq0E185KvfybKErDeJ/w2JS
 RP1y0Gdfny5H69tpwusnRbORp/k3Jr2bb4m0t5gaOr81lBcxGiwccEE86zBy6TmUSnMb
 HT1pAchvPwXeESplSo9k8cKqky2SOkr/mEKpnA7WQnDTeqS+ADz7DNyTWZkz/1XGa4Y/
 hBGPPK2vM+SNdfXm7jpNFSR/NhUOUKaDqI22uiujgWYEVQdkSWumzvijpyu7+38G3qJW
 jMT5ioj5SaPBOWJ//VzC+WHJODYz0L1zSO5DWMBX1EljDylA1Yr2eLce7I7dJxxFxTKi
 2uDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750432229; x=1751037029;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HKj94cGB7Qfm3a0es/oNe9gk1Rpl0uXuCTtRqkzq1Ho=;
 b=IqI31lNhoLxmQP2cD5hLPKsXtyhVr1Nrq9f64joN9IDNPoi2KV9M60ctnqmAOl4ESp
 FryNT54JC0VxaY1YXtyBoZgA4zvPmHVqyQKDflmGryXTiwGZvVIHF2z7aP10BeWQXIPS
 YJPMY1vucwWCPAdZFnInHL+7PjkpokgBQ6hhMfN4NNGAtBwUHzh+jveQaZYILrWjARsq
 xHVX8Ac003JiNvMrG8PrgM/Eeg5rtE8ZnVm+FkiJR3oYWEWNUM8OdorNZPcwR6DcdtWk
 nZGnrJqA2xAfXvYlrbQM7MSxBf7McJw6rLVbq0p61WCbnutLFMSlnaKDRBzyaJxfp245
 v+IQ==
X-Gm-Message-State: AOJu0YzkUASQRASneGliZg0P8n8eMW84W4VTmV32/VYANjir9aD5PkMM
 hlU5qGX3uGpIAsBbnoBPu8KUAwUitdI5bFM3/MvPnhHBXvBTW/P8vLhpqCiHpKsy8IePZ8GrmwN
 +UVu6
X-Gm-Gg: ASbGncssMFmFJm1RTsd8el/8ZRDxa72uerEfFfCixkFcI1BsNn6j4sgvCmgLIWEnK+f
 PEi3WAGG1rm0yUBs/uVPTCAYR7ijOCIiJ79C+27dKw2Bdcg5sUmaQenBrIfxqgfwsQX1aTBftFI
 EmbWDwvCR5AT/ub5j8+ZWCDMEXI3WbzacUAeL938fTzyM1dun+onOgXsTWd+RD/PWQ8qOQ2n289
 NU9Sw/Cg5Hd8657o034sIFXXwPVHAXrMZj+b0Grg9AMr8hYbwOLQHF7yg+SJbv36dM0+TbLn1OW
 zphFM1zOIAdrqCBQ8YTTqVkqP/VhA49g03RJrzuhPl24bKxyi31kaOMU21xC9qDekO6PCNMSB8p
 pb4ZY9ZpC0sX51v+zkkk9N8IQ1lZJlsIo/spd93wgygG1bKw=
X-Google-Smtp-Source: AGHT+IHZLNYCgzzN2bLE+627dgKiOuoHKAMnRT2oHJI+yf/dddgjppCUu/bQ+sofxvob9KRfKV2D1Q==
X-Received: by 2002:a05:620a:7083:b0:7d3:90f2:c19f with SMTP id
 af79cd13be357-7d3f9920e89mr493660685a.31.1750432227186; 
 Fri, 20 Jun 2025 08:10:27 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-114-64.cpe.distributel.net.
 [173.206.114.64]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d3f99fc0a8sm99405085a.80.2025.06.20.08.10.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 08:10:26 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Robert Marko <robert.marko@sartura.hr>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sumit Garg <sumit.garg@kernel.org>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH 1/3] mbedtls: Introduce subset of compiler-rt from LLVM
Date: Fri, 20 Jun 2025 08:10:08 -0700
Message-Id: <20250620151021.2711542-1-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Introduce the implementation of udivti3 and udivmodti4 from LLVM
compiler-rt builtins for building MbedTLS bignum module via Clang.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 lib/mbedtls/port/compiler-rt/LICENSE.TXT      | 311 ++++++++++++++++++
 lib/mbedtls/port/compiler-rt/README.txt       |  11 +
 .../compiler-rt/lib/builtins/int_endianness.h | 114 +++++++
 .../port/compiler-rt/lib/builtins/int_lib.h   | 171 ++++++++++
 .../port/compiler-rt/lib/builtins/int_types.h | 276 ++++++++++++++++
 .../port/compiler-rt/lib/builtins/int_util.h  |  47 +++
 .../compiler-rt/lib/builtins/udivmodti4.c     | 158 +++++++++
 .../port/compiler-rt/lib/builtins/udivti3.c   |  23 ++
 8 files changed, 1111 insertions(+)
 create mode 100644 lib/mbedtls/port/compiler-rt/LICENSE.TXT
 create mode 100644 lib/mbedtls/port/compiler-rt/README.txt
 create mode 100644 lib/mbedtls/port/compiler-rt/lib/builtins/int_endianness.h
 create mode 100644 lib/mbedtls/port/compiler-rt/lib/builtins/int_lib.h
 create mode 100644 lib/mbedtls/port/compiler-rt/lib/builtins/int_types.h
 create mode 100644 lib/mbedtls/port/compiler-rt/lib/builtins/int_util.h
 create mode 100644 lib/mbedtls/port/compiler-rt/lib/builtins/udivmodti4.c
 create mode 100644 lib/mbedtls/port/compiler-rt/lib/builtins/udivti3.c

diff --git a/lib/mbedtls/port/compiler-rt/LICENSE.TXT b/lib/mbedtls/port/compiler-rt/LICENSE.TXT
new file mode 100644
index 00000000000..5a79a1b9d5c
--- /dev/null
+++ b/lib/mbedtls/port/compiler-rt/LICENSE.TXT
@@ -0,0 +1,311 @@
+==============================================================================
+The LLVM Project is under the Apache License v2.0 with LLVM Exceptions:
+==============================================================================
+
+                                 Apache License
+                           Version 2.0, January 2004
+                        http://www.apache.org/licenses/
+
+    TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION
+
+    1. Definitions.
+
+      "License" shall mean the terms and conditions for use, reproduction,
+      and distribution as defined by Sections 1 through 9 of this document.
+
+      "Licensor" shall mean the copyright owner or entity authorized by
+      the copyright owner that is granting the License.
+
+      "Legal Entity" shall mean the union of the acting entity and all
+      other entities that control, are controlled by, or are under common
+      control with that entity. For the purposes of this definition,
+      "control" means (i) the power, direct or indirect, to cause the
+      direction or management of such entity, whether by contract or
+      otherwise, or (ii) ownership of fifty percent (50%) or more of the
+      outstanding shares, or (iii) beneficial ownership of such entity.
+
+      "You" (or "Your") shall mean an individual or Legal Entity
+      exercising permissions granted by this License.
+
+      "Source" form shall mean the preferred form for making modifications,
+      including but not limited to software source code, documentation
+      source, and configuration files.
+
+      "Object" form shall mean any form resulting from mechanical
+      transformation or translation of a Source form, including but
+      not limited to compiled object code, generated documentation,
+      and conversions to other media types.
+
+      "Work" shall mean the work of authorship, whether in Source or
+      Object form, made available under the License, as indicated by a
+      copyright notice that is included in or attached to the work
+      (an example is provided in the Appendix below).
+
+      "Derivative Works" shall mean any work, whether in Source or Object
+      form, that is based on (or derived from) the Work and for which the
+      editorial revisions, annotations, elaborations, or other modifications
+      represent, as a whole, an original work of authorship. For the purposes
+      of this License, Derivative Works shall not include works that remain
+      separable from, or merely link (or bind by name) to the interfaces of,
+      the Work and Derivative Works thereof.
+
+      "Contribution" shall mean any work of authorship, including
+      the original version of the Work and any modifications or additions
+      to that Work or Derivative Works thereof, that is intentionally
+      submitted to Licensor for inclusion in the Work by the copyright owner
+      or by an individual or Legal Entity authorized to submit on behalf of
+      the copyright owner. For the purposes of this definition, "submitted"
+      means any form of electronic, verbal, or written communication sent
+      to the Licensor or its representatives, including but not limited to
+      communication on electronic mailing lists, source code control systems,
+      and issue tracking systems that are managed by, or on behalf of, the
+      Licensor for the purpose of discussing and improving the Work, but
+      excluding communication that is conspicuously marked or otherwise
+      designated in writing by the copyright owner as "Not a Contribution."
+
+      "Contributor" shall mean Licensor and any individual or Legal Entity
+      on behalf of whom a Contribution has been received by Licensor and
+      subsequently incorporated within the Work.
+
+    2. Grant of Copyright License. Subject to the terms and conditions of
+      this License, each Contributor hereby grants to You a perpetual,
+      worldwide, non-exclusive, no-charge, royalty-free, irrevocable
+      copyright license to reproduce, prepare Derivative Works of,
+      publicly display, publicly perform, sublicense, and distribute the
+      Work and such Derivative Works in Source or Object form.
+
+    3. Grant of Patent License. Subject to the terms and conditions of
+      this License, each Contributor hereby grants to You a perpetual,
+      worldwide, non-exclusive, no-charge, royalty-free, irrevocable
+      (except as stated in this section) patent license to make, have made,
+      use, offer to sell, sell, import, and otherwise transfer the Work,
+      where such license applies only to those patent claims licensable
+      by such Contributor that are necessarily infringed by their
+      Contribution(s) alone or by combination of their Contribution(s)
+      with the Work to which such Contribution(s) was submitted. If You
+      institute patent litigation against any entity (including a
+      cross-claim or counterclaim in a lawsuit) alleging that the Work
+      or a Contribution incorporated within the Work constitutes direct
+      or contributory patent infringement, then any patent licenses
+      granted to You under this License for that Work shall terminate
+      as of the date such litigation is filed.
+
+    4. Redistribution. You may reproduce and distribute copies of the
+      Work or Derivative Works thereof in any medium, with or without
+      modifications, and in Source or Object form, provided that You
+      meet the following conditions:
+
+      (a) You must give any other recipients of the Work or
+          Derivative Works a copy of this License; and
+
+      (b) You must cause any modified files to carry prominent notices
+          stating that You changed the files; and
+
+      (c) You must retain, in the Source form of any Derivative Works
+          that You distribute, all copyright, patent, trademark, and
+          attribution notices from the Source form of the Work,
+          excluding those notices that do not pertain to any part of
+          the Derivative Works; and
+
+      (d) If the Work includes a "NOTICE" text file as part of its
+          distribution, then any Derivative Works that You distribute must
+          include a readable copy of the attribution notices contained
+          within such NOTICE file, excluding those notices that do not
+          pertain to any part of the Derivative Works, in at least one
+          of the following places: within a NOTICE text file distributed
+          as part of the Derivative Works; within the Source form or
+          documentation, if provided along with the Derivative Works; or,
+          within a display generated by the Derivative Works, if and
+          wherever such third-party notices normally appear. The contents
+          of the NOTICE file are for informational purposes only and
+          do not modify the License. You may add Your own attribution
+          notices within Derivative Works that You distribute, alongside
+          or as an addendum to the NOTICE text from the Work, provided
+          that such additional attribution notices cannot be construed
+          as modifying the License.
+
+      You may add Your own copyright statement to Your modifications and
+      may provide additional or different license terms and conditions
+      for use, reproduction, or distribution of Your modifications, or
+      for any such Derivative Works as a whole, provided Your use,
+      reproduction, and distribution of the Work otherwise complies with
+      the conditions stated in this License.
+
+    5. Submission of Contributions. Unless You explicitly state otherwise,
+      any Contribution intentionally submitted for inclusion in the Work
+      by You to the Licensor shall be under the terms and conditions of
+      this License, without any additional terms or conditions.
+      Notwithstanding the above, nothing herein shall supersede or modify
+      the terms of any separate license agreement you may have executed
+      with Licensor regarding such Contributions.
+
+    6. Trademarks. This License does not grant permission to use the trade
+      names, trademarks, service marks, or product names of the Licensor,
+      except as required for reasonable and customary use in describing the
+      origin of the Work and reproducing the content of the NOTICE file.
+
+    7. Disclaimer of Warranty. Unless required by applicable law or
+      agreed to in writing, Licensor provides the Work (and each
+      Contributor provides its Contributions) on an "AS IS" BASIS,
+      WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
+      implied, including, without limitation, any warranties or conditions
+      of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A
+      PARTICULAR PURPOSE. You are solely responsible for determining the
+      appropriateness of using or redistributing the Work and assume any
+      risks associated with Your exercise of permissions under this License.
+
+    8. Limitation of Liability. In no event and under no legal theory,
+      whether in tort (including negligence), contract, or otherwise,
+      unless required by applicable law (such as deliberate and grossly
+      negligent acts) or agreed to in writing, shall any Contributor be
+      liable to You for damages, including any direct, indirect, special,
+      incidental, or consequential damages of any character arising as a
+      result of this License or out of the use or inability to use the
+      Work (including but not limited to damages for loss of goodwill,
+      work stoppage, computer failure or malfunction, or any and all
+      other commercial damages or losses), even if such Contributor
+      has been advised of the possibility of such damages.
+
+    9. Accepting Warranty or Additional Liability. While redistributing
+      the Work or Derivative Works thereof, You may choose to offer,
+      and charge a fee for, acceptance of support, warranty, indemnity,
+      or other liability obligations and/or rights consistent with this
+      License. However, in accepting such obligations, You may act only
+      on Your own behalf and on Your sole responsibility, not on behalf
+      of any other Contributor, and only if You agree to indemnify,
+      defend, and hold each Contributor harmless for any liability
+      incurred by, or claims asserted against, such Contributor by reason
+      of your accepting any such warranty or additional liability.
+
+    END OF TERMS AND CONDITIONS
+
+    APPENDIX: How to apply the Apache License to your work.
+
+      To apply the Apache License to your work, attach the following
+      boilerplate notice, with the fields enclosed by brackets "[]"
+      replaced with your own identifying information. (Don't include
+      the brackets!)  The text should be enclosed in the appropriate
+      comment syntax for the file format. We also recommend that a
+      file or class name and description of purpose be included on the
+      same "printed page" as the copyright notice for easier
+      identification within third-party archives.
+
+    Copyright [yyyy] [name of copyright owner]
+
+    Licensed under the Apache License, Version 2.0 (the "License");
+    you may not use this file except in compliance with the License.
+    You may obtain a copy of the License at
+
+       http://www.apache.org/licenses/LICENSE-2.0
+
+    Unless required by applicable law or agreed to in writing, software
+    distributed under the License is distributed on an "AS IS" BASIS,
+    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+    See the License for the specific language governing permissions and
+    limitations under the License.
+
+
+---- LLVM Exceptions to the Apache 2.0 License ----
+
+As an exception, if, as a result of your compiling your source code, portions
+of this Software are embedded into an Object form of such source code, you
+may redistribute such embedded portions in such Object form without complying
+with the conditions of Sections 4(a), 4(b) and 4(d) of the License.
+
+In addition, if you combine or link compiled forms of this Software with
+software that is licensed under the GPLv2 ("Combined Software") and if a
+court of competent jurisdiction determines that the patent provision (Section
+3), the indemnity provision (Section 9) or other Section of the License
+conflicts with the conditions of the GPLv2, you may retroactively and
+prospectively choose to deem waived or otherwise exclude such Section(s) of
+the License, but only in their entirety and only with respect to the Combined
+Software.
+
+==============================================================================
+Software from third parties included in the LLVM Project:
+==============================================================================
+The LLVM Project contains third party software which is under different license
+terms. All such code will be identified clearly using at least one of two
+mechanisms:
+1) It will be in a separate directory tree with its own `LICENSE.txt` or
+   `LICENSE` file at the top containing the specific license and restrictions
+   which apply to that software, or
+2) It will contain specific license and restriction terms at the top of every
+   file.
+
+==============================================================================
+Legacy LLVM License (https://llvm.org/docs/DeveloperPolicy.html#legacy):
+==============================================================================
+
+The compiler_rt library is dual licensed under both the University of Illinois
+"BSD-Like" license and the MIT license.  As a user of this code you may choose
+to use it under either license.  As a contributor, you agree to allow your code
+to be used under both.
+
+Full text of the relevant licenses is included below.
+
+==============================================================================
+
+University of Illinois/NCSA
+Open Source License
+
+Copyright (c) 2009-2019 by the contributors listed in CREDITS.TXT
+
+All rights reserved.
+
+Developed by:
+
+    LLVM Team
+
+    University of Illinois at Urbana-Champaign
+
+    http://llvm.org
+
+Permission is hereby granted, free of charge, to any person obtaining a copy of
+this software and associated documentation files (the "Software"), to deal with
+the Software without restriction, including without limitation the rights to
+use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
+of the Software, and to permit persons to whom the Software is furnished to do
+so, subject to the following conditions:
+
+    * Redistributions of source code must retain the above copyright notice,
+      this list of conditions and the following disclaimers.
+
+    * Redistributions in binary form must reproduce the above copyright notice,
+      this list of conditions and the following disclaimers in the
+      documentation and/or other materials provided with the distribution.
+
+    * Neither the names of the LLVM Team, University of Illinois at
+      Urbana-Champaign, nor the names of its contributors may be used to
+      endorse or promote products derived from this Software without specific
+      prior written permission.
+
+THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
+FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
+CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS WITH THE
+SOFTWARE.
+
+==============================================================================
+
+Copyright (c) 2009-2015 by the contributors listed in CREDITS.TXT
+
+Permission is hereby granted, free of charge, to any person obtaining a copy
+of this software and associated documentation files (the "Software"), to deal
+in the Software without restriction, including without limitation the rights
+to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+copies of the Software, and to permit persons to whom the Software is
+furnished to do so, subject to the following conditions:
+
+The above copyright notice and this permission notice shall be included in
+all copies or substantial portions of the Software.
+
+THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+THE SOFTWARE.
diff --git a/lib/mbedtls/port/compiler-rt/README.txt b/lib/mbedtls/port/compiler-rt/README.txt
new file mode 100644
index 00000000000..fc8843246e2
--- /dev/null
+++ b/lib/mbedtls/port/compiler-rt/README.txt
@@ -0,0 +1,11 @@
+Compiler-RT
+================================
+
+This directory and its subdirectories contain source code for the compiler
+support routines.
+
+Compiler-RT is open source software. You may freely distribute it under the
+terms of the license agreement found in LICENSE.txt.
+
+================================
+
diff --git a/lib/mbedtls/port/compiler-rt/lib/builtins/int_endianness.h b/lib/mbedtls/port/compiler-rt/lib/builtins/int_endianness.h
new file mode 100644
index 00000000000..291c6b58c8e
--- /dev/null
+++ b/lib/mbedtls/port/compiler-rt/lib/builtins/int_endianness.h
@@ -0,0 +1,114 @@
+//===-- int_endianness.h - configuration header for compiler-rt -----------===//
+//
+// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
+// See https://llvm.org/LICENSE.txt for license information.
+// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
+//
+//===----------------------------------------------------------------------===//
+//
+// This file is a configuration header for compiler-rt.
+// This file is not part of the interface of this library.
+//
+//===----------------------------------------------------------------------===//
+
+#ifndef INT_ENDIANNESS_H
+#define INT_ENDIANNESS_H
+
+#if defined(__BYTE_ORDER__) && defined(__ORDER_BIG_ENDIAN__) &&                \
+    defined(__ORDER_LITTLE_ENDIAN__)
+
+// Clang and GCC provide built-in endianness definitions.
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+#define _YUGA_LITTLE_ENDIAN 0
+#define _YUGA_BIG_ENDIAN 1
+#elif __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+#define _YUGA_LITTLE_ENDIAN 1
+#define _YUGA_BIG_ENDIAN 0
+#endif // __BYTE_ORDER__
+
+#else // Compilers other than Clang or GCC.
+
+#if defined(__SVR4) && defined(__sun)
+#include <sys/byteorder.h>
+
+#if defined(_BIG_ENDIAN)
+#define _YUGA_LITTLE_ENDIAN 0
+#define _YUGA_BIG_ENDIAN 1
+#elif defined(_LITTLE_ENDIAN)
+#define _YUGA_LITTLE_ENDIAN 1
+#define _YUGA_BIG_ENDIAN 0
+#else // !_LITTLE_ENDIAN
+#error "unknown endianness"
+#endif // !_LITTLE_ENDIAN
+
+#endif // Solaris
+
+// ..
+
+#if defined(__FreeBSD__) || defined(__NetBSD__) || defined(__DragonFly__) ||   \
+    defined(__minix)
+#include <sys/endian.h>
+
+#if _BYTE_ORDER == _BIG_ENDIAN
+#define _YUGA_LITTLE_ENDIAN 0
+#define _YUGA_BIG_ENDIAN 1
+#elif _BYTE_ORDER == _LITTLE_ENDIAN
+#define _YUGA_LITTLE_ENDIAN 1
+#define _YUGA_BIG_ENDIAN 0
+#endif // _BYTE_ORDER
+
+#endif // *BSD
+
+#if defined(__OpenBSD__)
+#include <machine/endian.h>
+
+#if _BYTE_ORDER == _BIG_ENDIAN
+#define _YUGA_LITTLE_ENDIAN 0
+#define _YUGA_BIG_ENDIAN 1
+#elif _BYTE_ORDER == _LITTLE_ENDIAN
+#define _YUGA_LITTLE_ENDIAN 1
+#define _YUGA_BIG_ENDIAN 0
+#endif // _BYTE_ORDER
+
+#endif // OpenBSD
+
+// ..
+
+// Mac OSX has __BIG_ENDIAN__ or __LITTLE_ENDIAN__ automatically set by the
+// compiler (at least with GCC)
+#if defined(__APPLE__) || defined(__ellcc__)
+
+#ifdef __BIG_ENDIAN__
+#if __BIG_ENDIAN__
+#define _YUGA_LITTLE_ENDIAN 0
+#define _YUGA_BIG_ENDIAN 1
+#endif
+#endif // __BIG_ENDIAN__
+
+#ifdef __LITTLE_ENDIAN__
+#if __LITTLE_ENDIAN__
+#define _YUGA_LITTLE_ENDIAN 1
+#define _YUGA_BIG_ENDIAN 0
+#endif
+#endif // __LITTLE_ENDIAN__
+
+#endif // Mac OSX
+
+// ..
+
+#if defined(_WIN32)
+
+#define _YUGA_LITTLE_ENDIAN 1
+#define _YUGA_BIG_ENDIAN 0
+
+#endif // Windows
+
+#endif // Clang or GCC.
+
+// .
+
+#if !defined(_YUGA_LITTLE_ENDIAN) || !defined(_YUGA_BIG_ENDIAN)
+#error Unable to determine endian
+#endif // Check we found an endianness correctly.
+
+#endif // INT_ENDIANNESS_H
diff --git a/lib/mbedtls/port/compiler-rt/lib/builtins/int_lib.h b/lib/mbedtls/port/compiler-rt/lib/builtins/int_lib.h
new file mode 100644
index 00000000000..f6c1b7cff4b
--- /dev/null
+++ b/lib/mbedtls/port/compiler-rt/lib/builtins/int_lib.h
@@ -0,0 +1,171 @@
+//===-- int_lib.h - configuration header for compiler-rt  -----------------===//
+//
+// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
+// See https://llvm.org/LICENSE.txt for license information.
+// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
+//
+//===----------------------------------------------------------------------===//
+//
+// This file is a configuration header for compiler-rt.
+// This file is not part of the interface of this library.
+//
+//===----------------------------------------------------------------------===//
+
+#ifndef INT_LIB_H
+#define INT_LIB_H
+
+// Assumption: Signed integral is 2's complement.
+// Assumption: Right shift of signed negative is arithmetic shift.
+// Assumption: Endianness is little or big (not mixed).
+
+// ABI macro definitions
+
+#if __ARM_EABI__
+#ifdef COMPILER_RT_ARMHF_TARGET
+#define COMPILER_RT_ABI
+#else
+#define COMPILER_RT_ABI __attribute__((__pcs__("aapcs")))
+#endif
+#else
+#define COMPILER_RT_ABI
+#endif
+
+#define AEABI_RTABI __attribute__((__pcs__("aapcs")))
+
+#if defined(_MSC_VER) && !defined(__clang__)
+#define ALWAYS_INLINE __forceinline
+#define NOINLINE __declspec(noinline)
+#define NORETURN __declspec(noreturn)
+#define UNUSED
+#else
+#define ALWAYS_INLINE __attribute__((always_inline))
+#define NOINLINE __attribute__((noinline))
+#define NORETURN __attribute__((noreturn))
+#define UNUSED __attribute__((unused))
+#endif
+
+#define STR(a) #a
+#define XSTR(a) STR(a)
+#define SYMBOL_NAME(name) XSTR(__USER_LABEL_PREFIX__) #name
+
+#if defined(__ELF__) || defined(__MINGW32__) || defined(__wasm__) ||           \
+    defined(_AIX)    || defined(__CYGWIN__)
+#define COMPILER_RT_ALIAS(name, aliasname) \
+  COMPILER_RT_ABI __typeof(name) aliasname __attribute__((__alias__(#name)));
+#elif defined(__APPLE__)
+#if defined(VISIBILITY_HIDDEN)
+#define COMPILER_RT_ALIAS_VISIBILITY(name) \
+  __asm__(".private_extern " SYMBOL_NAME(name));
+#else
+#define COMPILER_RT_ALIAS_VISIBILITY(name)
+#endif
+#define COMPILER_RT_ALIAS(name, aliasname) \
+  __asm__(".globl " SYMBOL_NAME(aliasname)); \
+  COMPILER_RT_ALIAS_VISIBILITY(aliasname) \
+  __asm__(SYMBOL_NAME(aliasname) " = " SYMBOL_NAME(name)); \
+  COMPILER_RT_ABI __typeof(name) aliasname;
+#elif defined(_WIN32)
+#define COMPILER_RT_ALIAS(name, aliasname)
+#else
+#error Unsupported target
+#endif
+
+#if (defined(__FreeBSD__) || defined(__NetBSD__)) &&                           \
+    (defined(_KERNEL) || defined(_STANDALONE))
+//
+// Kernel and boot environment can't use normal headers,
+// so use the equivalent system headers.
+// NB: FreeBSD (and OpenBSD) deprecate machine/limits.h in
+// favour of sys/limits.h, so prefer the former, but fall
+// back on the latter if not available since NetBSD only has
+// the latter.
+//
+#if defined(__has_include) && __has_include(<sys/limits.h>)
+#include <sys/limits.h>
+#else
+#include <machine/limits.h>
+#endif
+#include <sys/stdint.h>
+#include <sys/types.h>
+#else
+// Include the standard compiler builtin headers we use functionality from.
+#include <float.h>
+#include <limits.h>
+#include <stdbool.h>
+#include <stdint.h>
+#endif
+
+// Include the commonly used internal type definitions.
+#include "int_types.h"
+
+// Include internal utility function declarations.
+#include "int_util.h"
+
+COMPILER_RT_ABI int __paritysi2(si_int a);
+COMPILER_RT_ABI int __paritydi2(di_int a);
+
+COMPILER_RT_ABI di_int __divdi3(di_int a, di_int b);
+COMPILER_RT_ABI si_int __divsi3(si_int a, si_int b);
+COMPILER_RT_ABI su_int __udivsi3(su_int n, su_int d);
+
+COMPILER_RT_ABI su_int __udivmodsi4(su_int a, su_int b, su_int *rem);
+COMPILER_RT_ABI du_int __udivmoddi4(du_int a, du_int b, du_int *rem);
+#ifdef CRT_HAS_128BIT
+COMPILER_RT_ABI int __clzti2(ti_int a);
+COMPILER_RT_ABI tu_int __udivmodti4(tu_int a, tu_int b, tu_int *rem);
+#endif
+
+// Definitions for builtins unavailable on MSVC
+#if defined(_MSC_VER) && !defined(__clang__)
+#include <intrin.h>
+
+static int __inline __builtin_ctz(uint32_t value) {
+  unsigned long trailing_zero = 0;
+  if (_BitScanForward(&trailing_zero, value))
+    return trailing_zero;
+  return 32;
+}
+
+static int __inline __builtin_clz(uint32_t value) {
+  unsigned long leading_zero = 0;
+  if (_BitScanReverse(&leading_zero, value))
+    return 31 - leading_zero;
+  return 32;
+}
+
+#if defined(_M_ARM) || defined(_M_X64)
+static int __inline __builtin_clzll(uint64_t value) {
+  unsigned long leading_zero = 0;
+  if (_BitScanReverse64(&leading_zero, value))
+    return 63 - leading_zero;
+  return 64;
+}
+#else
+static int __inline __builtin_clzll(uint64_t value) {
+  if (value == 0)
+    return 64;
+  uint32_t msh = (uint32_t)(value >> 32);
+  uint32_t lsh = (uint32_t)(value & 0xFFFFFFFF);
+  if (msh != 0)
+    return __builtin_clz(msh);
+  return 32 + __builtin_clz(lsh);
+}
+#endif
+
+#define __builtin_clzl __builtin_clzll
+
+static bool __inline __builtin_sadd_overflow(int x, int y, int *result) {
+  if ((x < 0) != (y < 0)) {
+    *result = x + y;
+    return false;
+  }
+  int tmp = (unsigned int)x + (unsigned int)y;
+  if ((tmp < 0) != (x < 0))
+    return true;
+  *result = tmp;
+  return false;
+}
+
+#endif // defined(_MSC_VER) && !defined(__clang__)
+
+#endif // INT_LIB_H
diff --git a/lib/mbedtls/port/compiler-rt/lib/builtins/int_types.h b/lib/mbedtls/port/compiler-rt/lib/builtins/int_types.h
new file mode 100644
index 00000000000..48862f36421
--- /dev/null
+++ b/lib/mbedtls/port/compiler-rt/lib/builtins/int_types.h
@@ -0,0 +1,276 @@
+//===-- int_lib.h - configuration header for compiler-rt  -----------------===//
+//
+// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
+// See https://llvm.org/LICENSE.txt for license information.
+// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
+//
+//===----------------------------------------------------------------------===//
+//
+// This file is not part of the interface of this library.
+//
+// This file defines various standard types, most importantly a number of unions
+// used to access parts of larger types.
+//
+//===----------------------------------------------------------------------===//
+
+#ifndef INT_TYPES_H
+#define INT_TYPES_H
+
+#include "int_endianness.h"
+
+// si_int is defined in Linux sysroot's asm-generic/siginfo.h
+#ifdef si_int
+#undef si_int
+#endif
+typedef int32_t si_int;
+typedef uint32_t su_int;
+#if UINT_MAX == 0xFFFFFFFF
+#define clzsi __builtin_clz
+#define ctzsi __builtin_ctz
+#elif ULONG_MAX == 0xFFFFFFFF
+#define clzsi __builtin_clzl
+#define ctzsi __builtin_ctzl
+#else
+#error could not determine appropriate clzsi macro for this system
+#endif
+
+typedef int64_t di_int;
+typedef uint64_t du_int;
+
+typedef union {
+  di_int all;
+  struct {
+#if _YUGA_LITTLE_ENDIAN
+    su_int low;
+    si_int high;
+#else
+    si_int high;
+    su_int low;
+#endif // _YUGA_LITTLE_ENDIAN
+  } s;
+} dwords;
+
+typedef union {
+  du_int all;
+  struct {
+#if _YUGA_LITTLE_ENDIAN
+    su_int low;
+    su_int high;
+#else
+    su_int high;
+    su_int low;
+#endif // _YUGA_LITTLE_ENDIAN
+  } s;
+} udwords;
+
+#if defined(__LP64__) || defined(__wasm__) || defined(__mips64) ||             \
+    defined(__SIZEOF_INT128__) || defined(_WIN64)
+#define CRT_HAS_128BIT
+#endif
+
+// MSVC doesn't have a working 128bit integer type. Users should really compile
+// compiler-rt with clang, but if they happen to be doing a standalone build for
+// asan or something else, disable the 128 bit parts so things sort of work.
+#if defined(_MSC_VER) && !defined(__clang__)
+#undef CRT_HAS_128BIT
+#endif
+
+#ifdef CRT_HAS_128BIT
+typedef int ti_int __attribute__((mode(TI)));
+typedef unsigned tu_int __attribute__((mode(TI)));
+
+typedef union {
+  ti_int all;
+  struct {
+#if _YUGA_LITTLE_ENDIAN
+    du_int low;
+    di_int high;
+#else
+    di_int high;
+    du_int low;
+#endif // _YUGA_LITTLE_ENDIAN
+  } s;
+} twords;
+
+typedef union {
+  tu_int all;
+  struct {
+#if _YUGA_LITTLE_ENDIAN
+    du_int low;
+    du_int high;
+#else
+    du_int high;
+    du_int low;
+#endif // _YUGA_LITTLE_ENDIAN
+  } s;
+} utwords;
+
+static __inline ti_int make_ti(di_int h, di_int l) {
+  twords r;
+  r.s.high = (du_int)h;
+  r.s.low = (du_int)l;
+  return r.all;
+}
+
+static __inline tu_int make_tu(du_int h, du_int l) {
+  utwords r;
+  r.s.high = h;
+  r.s.low = l;
+  return r.all;
+}
+
+#endif // CRT_HAS_128BIT
+
+// FreeBSD's boot environment does not support using floating-point and poisons
+// the float and double keywords.
+#if defined(__FreeBSD__) && defined(_STANDALONE)
+#define CRT_HAS_FLOATING_POINT 0
+#else
+#define CRT_HAS_FLOATING_POINT 1
+#endif
+
+#if CRT_HAS_FLOATING_POINT
+typedef union {
+  su_int u;
+  float f;
+} float_bits;
+
+typedef union {
+  udwords u;
+  double f;
+} double_bits;
+
+typedef struct {
+#if _YUGA_LITTLE_ENDIAN
+  udwords low;
+  udwords high;
+#else
+  udwords high;
+  udwords low;
+#endif // _YUGA_LITTLE_ENDIAN
+} uqwords;
+
+// Check if the target supports 80 bit extended precision long doubles.
+// Notably, on x86 Windows, MSVC only provides a 64-bit long double, but GCC
+// still makes it 80 bits. Clang will match whatever compiler it is trying to
+// be compatible with. On 32-bit x86 Android, long double is 64 bits, while on
+// x86_64 Android, long double is 128 bits.
+#if (defined(__i386__) || defined(__x86_64__)) &&                              \
+    !(defined(_MSC_VER) || defined(__ANDROID__))
+#define HAS_80_BIT_LONG_DOUBLE 1
+#elif defined(__m68k__) || defined(__ia64__)
+#define HAS_80_BIT_LONG_DOUBLE 1
+#else
+#define HAS_80_BIT_LONG_DOUBLE 0
+#endif
+
+#if HAS_80_BIT_LONG_DOUBLE
+typedef long double xf_float;
+typedef union {
+  uqwords u;
+  xf_float f;
+} xf_bits;
+#endif
+
+#ifdef __powerpc64__
+// From https://gcc.gnu.org/wiki/Ieee128PowerPC:
+// PowerPC64 uses the following suffixes:
+// IFmode: IBM extended double
+// KFmode: IEEE 128-bit floating point
+// TFmode: Matches the default for long double. With -mabi=ieeelongdouble,
+//         it is IEEE 128-bit, with -mabi=ibmlongdouble IBM extended double
+// Since compiler-rt only implements the tf set of libcalls, we use long double
+// for the tf_float typedef.
+typedef long double tf_float;
+#define CRT_LDBL_128BIT
+#define CRT_HAS_F128
+#if __LDBL_MANT_DIG__ == 113 && !defined(__LONG_DOUBLE_IBM128__)
+#define CRT_HAS_IEEE_TF
+#define CRT_LDBL_IEEE_F128
+#endif
+#define TF_C(x) x##L
+#elif __LDBL_MANT_DIG__ == 113 ||                                              \
+    (__FLT_RADIX__ == 16 && __LDBL_MANT_DIG__ == 28)
+// Use long double instead of __float128 if it matches the IEEE 128-bit format
+// or the IBM hexadecimal format.
+#define CRT_LDBL_128BIT
+#define CRT_HAS_F128
+#if __LDBL_MANT_DIG__ == 113
+#define CRT_HAS_IEEE_TF
+#define CRT_LDBL_IEEE_F128
+#endif
+typedef long double tf_float;
+#define TF_C(x) x##L
+#elif defined(__FLOAT128__) || defined(__SIZEOF_FLOAT128__)
+#define CRT_HAS___FLOAT128_KEYWORD
+#define CRT_HAS_F128
+// NB: we assume the __float128 type uses IEEE representation.
+#define CRT_HAS_IEEE_TF
+typedef __float128 tf_float;
+#define TF_C(x) x##Q
+#endif
+
+#ifdef CRT_HAS_F128
+typedef union {
+  uqwords u;
+  tf_float f;
+} tf_bits;
+#endif
+
+// __(u)int128_t is currently needed to compile the *tf builtins as we would
+// otherwise need to manually expand the bit manipulation on two 64-bit value.
+#if defined(CRT_HAS_128BIT) && defined(CRT_HAS_F128)
+#define CRT_HAS_TF_MODE
+#endif
+
+#if __STDC_VERSION__ >= 199901L
+typedef float _Complex Fcomplex;
+typedef double _Complex Dcomplex;
+typedef long double _Complex Lcomplex;
+#if defined(CRT_LDBL_128BIT)
+typedef Lcomplex Qcomplex;
+#define CRT_HAS_NATIVE_COMPLEX_F128
+#elif defined(CRT_HAS___FLOAT128_KEYWORD)
+#if defined(__clang_major__) && __clang_major__ > 10
+// Clang prior to 11 did not support __float128 _Complex.
+typedef __float128 _Complex Qcomplex;
+#define CRT_HAS_NATIVE_COMPLEX_F128
+#elif defined(__GNUC__) && __GNUC__ >= 7
+// GCC does not allow __float128 _Complex, but accepts _Float128 _Complex.
+typedef _Float128 _Complex Qcomplex;
+#define CRT_HAS_NATIVE_COMPLEX_F128
+#endif
+#endif
+
+#define COMPLEX_REAL(x) __real__(x)
+#define COMPLEX_IMAGINARY(x) __imag__(x)
+#else
+typedef struct {
+  float real, imaginary;
+} Fcomplex;
+
+typedef struct {
+  double real, imaginary;
+} Dcomplex;
+
+typedef struct {
+  long double real, imaginary;
+} Lcomplex;
+
+#define COMPLEX_REAL(x) (x).real
+#define COMPLEX_IMAGINARY(x) (x).imaginary
+#endif
+
+#ifdef CRT_HAS_NATIVE_COMPLEX_F128
+#define COMPLEXTF_REAL(x) __real__(x)
+#define COMPLEXTF_IMAGINARY(x) __imag__(x)
+#elif defined(CRT_HAS_F128)
+typedef struct {
+  tf_float real, imaginary;
+} Qcomplex;
+#define COMPLEXTF_REAL(x) (x).real
+#define COMPLEXTF_IMAGINARY(x) (x).imaginary
+#endif
+
+#endif // CRT_HAS_FLOATING_POINT
+#endif // INT_TYPES_H
diff --git a/lib/mbedtls/port/compiler-rt/lib/builtins/int_util.h b/lib/mbedtls/port/compiler-rt/lib/builtins/int_util.h
new file mode 100644
index 00000000000..c372c2edc63
--- /dev/null
+++ b/lib/mbedtls/port/compiler-rt/lib/builtins/int_util.h
@@ -0,0 +1,47 @@
+//===-- int_util.h - internal utility functions ---------------------------===//
+//
+// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
+// See https://llvm.org/LICENSE.txt for license information.
+// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
+//
+//===----------------------------------------------------------------------===//
+//
+// This file is not part of the interface of this library.
+//
+// This file defines non-inline utilities which are available for use in the
+// library. The function definitions themselves are all contained in int_util.c
+// which will always be compiled into any compiler-rt library.
+//
+//===----------------------------------------------------------------------===//
+
+#ifndef INT_UTIL_H
+#define INT_UTIL_H
+
+/// \brief Trigger a program abort (or panic for kernel code).
+#define compilerrt_abort() __compilerrt_abort_impl(__FILE__, __LINE__, __func__)
+
+NORETURN void __compilerrt_abort_impl(const char *file, int line,
+                                      const char *function);
+
+#define COMPILE_TIME_ASSERT(expr) COMPILE_TIME_ASSERT1(expr, __COUNTER__)
+#define COMPILE_TIME_ASSERT1(expr, cnt) COMPILE_TIME_ASSERT2(expr, cnt)
+#define COMPILE_TIME_ASSERT2(expr, cnt)                                        \
+  typedef char ct_assert_##cnt[(expr) ? 1 : -1] UNUSED
+
+// Force unrolling the code specified to be repeated N times.
+#define REPEAT_0_TIMES(code_to_repeat) /* do nothing */
+#define REPEAT_1_TIMES(code_to_repeat) code_to_repeat
+#define REPEAT_2_TIMES(code_to_repeat)                                         \
+  REPEAT_1_TIMES(code_to_repeat)                                               \
+  code_to_repeat
+#define REPEAT_3_TIMES(code_to_repeat)                                         \
+  REPEAT_2_TIMES(code_to_repeat)                                               \
+  code_to_repeat
+#define REPEAT_4_TIMES(code_to_repeat)                                         \
+  REPEAT_3_TIMES(code_to_repeat)                                               \
+  code_to_repeat
+
+#define REPEAT_N_TIMES_(N, code_to_repeat) REPEAT_##N##_TIMES(code_to_repeat)
+#define REPEAT_N_TIMES(N, code_to_repeat) REPEAT_N_TIMES_(N, code_to_repeat)
+
+#endif // INT_UTIL_H
diff --git a/lib/mbedtls/port/compiler-rt/lib/builtins/udivmodti4.c b/lib/mbedtls/port/compiler-rt/lib/builtins/udivmodti4.c
new file mode 100644
index 00000000000..55def37c9e1
--- /dev/null
+++ b/lib/mbedtls/port/compiler-rt/lib/builtins/udivmodti4.c
@@ -0,0 +1,158 @@
+//===-- udivmodti4.c - Implement __udivmodti4 -----------------------------===//
+//
+// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
+// See https://llvm.org/LICENSE.txt for license information.
+// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
+//
+//===----------------------------------------------------------------------===//
+//
+// This file implements __udivmodti4 for the compiler_rt library.
+//
+//===----------------------------------------------------------------------===//
+
+#include "int_lib.h"
+
+#ifdef CRT_HAS_128BIT
+
+// Returns the 128 bit division result by 64 bit. Result must fit in 64 bits.
+// Remainder stored in r.
+// Taken and adjusted from libdivide libdivide_128_div_64_to_64 division
+// fallback. For a correctness proof see the reference for this algorithm
+// in Knuth, Volume 2, section 4.3.1, Algorithm D.
+UNUSED
+static inline du_int udiv128by64to64default(du_int u1, du_int u0, du_int v,
+                                            du_int *r) {
+  const unsigned n_udword_bits = sizeof(du_int) * CHAR_BIT;
+  const du_int b = (1ULL << (n_udword_bits / 2)); // Number base (32 bits)
+  du_int un1, un0;                                // Norm. dividend LSD's
+  du_int vn1, vn0;                                // Norm. divisor digits
+  du_int q1, q0;                                  // Quotient digits
+  du_int un64, un21, un10;                        // Dividend digit pairs
+  du_int rhat;                                    // A remainder
+  si_int s;                                       // Shift amount for normalization
+
+  s = __builtin_clzll(v);
+  if (s > 0) {
+    // Normalize the divisor.
+    v = v << s;
+    un64 = (u1 << s) | (u0 >> (n_udword_bits - s));
+    un10 = u0 << s; // Shift dividend left
+  } else {
+    // Avoid undefined behavior of (u0 >> 64).
+    un64 = u1;
+    un10 = u0;
+  }
+
+  // Break divisor up into two 32-bit digits.
+  vn1 = v >> (n_udword_bits / 2);
+  vn0 = v & 0xFFFFFFFF;
+
+  // Break right half of dividend into two digits.
+  un1 = un10 >> (n_udword_bits / 2);
+  un0 = un10 & 0xFFFFFFFF;
+
+  // Compute the first quotient digit, q1.
+  q1 = un64 / vn1;
+  rhat = un64 - q1 * vn1;
+
+  // q1 has at most error 2. No more than 2 iterations.
+  while (q1 >= b || q1 * vn0 > b * rhat + un1) {
+    q1 = q1 - 1;
+    rhat = rhat + vn1;
+    if (rhat >= b)
+      break;
+  }
+
+  un21 = un64 * b + un1 - q1 * v;
+
+  // Compute the second quotient digit.
+  q0 = un21 / vn1;
+  rhat = un21 - q0 * vn1;
+
+  // q0 has at most error 2. No more than 2 iterations.
+  while (q0 >= b || q0 * vn0 > b * rhat + un0) {
+    q0 = q0 - 1;
+    rhat = rhat + vn1;
+    if (rhat >= b)
+      break;
+  }
+
+  *r = (un21 * b + un0 - q0 * v) >> s;
+  return q1 * b + q0;
+}
+
+static inline du_int udiv128by64to64(du_int u1, du_int u0, du_int v,
+                                     du_int *r) {
+#if defined(__x86_64__)
+  du_int result;
+  __asm__("divq %[v]"
+          : "=a"(result), "=d"(*r)
+          : [ v ] "r"(v), "a"(u0), "d"(u1));
+  return result;
+#else
+  return udiv128by64to64default(u1, u0, v, r);
+#endif
+}
+
+// Effects: if rem != 0, *rem = a % b
+// Returns: a / b
+
+COMPILER_RT_ABI tu_int __udivmodti4(tu_int a, tu_int b, tu_int *rem) {
+  const unsigned n_utword_bits = sizeof(tu_int) * CHAR_BIT;
+  utwords dividend;
+  dividend.all = a;
+  utwords divisor;
+  divisor.all = b;
+  utwords quotient;
+  utwords remainder;
+  if (divisor.all > dividend.all) {
+    if (rem)
+      *rem = dividend.all;
+    return 0;
+  }
+  // When the divisor fits in 64 bits, we can use an optimized path.
+  if (divisor.s.high == 0) {
+    remainder.s.high = 0;
+    if (dividend.s.high < divisor.s.low) {
+      // The result fits in 64 bits.
+      quotient.s.low = udiv128by64to64(dividend.s.high, dividend.s.low,
+                                       divisor.s.low, &remainder.s.low);
+      quotient.s.high = 0;
+    } else {
+      // First, divide with the high part to get the remainder in dividend.s.high.
+      // After that dividend.s.high < divisor.s.low.
+      quotient.s.high = dividend.s.high / divisor.s.low;
+      dividend.s.high = dividend.s.high % divisor.s.low;
+      quotient.s.low = udiv128by64to64(dividend.s.high, dividend.s.low,
+                                       divisor.s.low, &remainder.s.low);
+    }
+    if (rem)
+      *rem = remainder.all;
+    return quotient.all;
+  }
+  // 0 <= shift <= 63.
+  si_int shift =
+      __builtin_clzll(divisor.s.high) - __builtin_clzll(dividend.s.high);
+  divisor.all <<= shift;
+  quotient.s.high = 0;
+  quotient.s.low = 0;
+  for (; shift >= 0; --shift) {
+    quotient.s.low <<= 1;
+    // Branch free version of.
+    // if (dividend.all >= divisor.all)
+    // {
+    //    dividend.all -= divisor.all;
+    //    carry = 1;
+    // }
+    const ti_int s =
+        (ti_int)(divisor.all - dividend.all - 1) >> (n_utword_bits - 1);
+    quotient.s.low |= s & 1;
+    dividend.all -= divisor.all & s;
+    divisor.all >>= 1;
+  }
+  if (rem)
+    *rem = dividend.all;
+  return quotient.all;
+}
+
+#endif // CRT_HAS_128BIT
diff --git a/lib/mbedtls/port/compiler-rt/lib/builtins/udivti3.c b/lib/mbedtls/port/compiler-rt/lib/builtins/udivti3.c
new file mode 100644
index 00000000000..4c82040b88c
--- /dev/null
+++ b/lib/mbedtls/port/compiler-rt/lib/builtins/udivti3.c
@@ -0,0 +1,23 @@
+//===-- udivti3.c - Implement __udivti3 -----------------------------------===//
+//
+// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
+// See https://llvm.org/LICENSE.txt for license information.
+// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
+//
+//===----------------------------------------------------------------------===//
+//
+// This file implements __udivti3 for the compiler_rt library.
+//
+//===----------------------------------------------------------------------===//
+
+#include "int_lib.h"
+
+#ifdef CRT_HAS_128BIT
+
+// Returns: a / b
+
+COMPILER_RT_ABI tu_int __udivti3(tu_int a, tu_int b) {
+  return __udivmodti4(a, b, 0);
+}
+
+#endif // CRT_HAS_128BIT
-- 
2.25.1

